#!/usr/bin/env python

"""
Copyright (c) Marc-Antoine Loignon
See the file 'LICENSE' for copying permission
"""

import re
import sys
import json
import glob2
import os.path
import fileinput
import subprocess
import urllib.request

from shutil import copyfile
from bs4 import BeautifulSoup
from make_var import make_vars


prerequisite_content = """
[dependency](www) <br/>
description
"""

def edit_file(filename):
    """
    This function is used to edit file.
    """
    with fileinput.input(filename, inplace=1) as f:
        for line in f:
            yield line.rstrip('\n')

def replace_last(source_string, replace_what, replace_with):
    """
    Replace characters at the end of a python string
    """
    head, _sep, tail = source_string.rpartition(replace_what)
    return head + replace_with + tail

def get_puppet_information_by_dependency(package):
    """
    Get puppet module information by dependency.
    """
    host = 'https://forge.puppet.com/modules/'
    path = package.replace('-', '/')

    fp = urllib.request.urlopen(host+path)
    content = fp.read()

    soup = BeautifulSoup(content, features="html.parser")
    regex = re.compile('.ModuleTitle_description__*')

    for div in soup.find_all("div", { "class" : regex }):
        return {
            'description': div.get_text(),
            'www': host+path
        }

def get_puppet_dependencies_json(path):
    """
    Get puppet dependencies informations in json file.
    """
    if os.path.exists(path):
        with open(path, "r") as f:
            return json.load(f)

    return {}

def get_puppet_dependencies(dependencies):
    """
    Get puppet dependencies and its informations.
    """
    path = 'script/puppet_dependencies.json'
    json_content = get_puppet_dependencies_json(path)
    data = {}

    for dependency in dependencies:
        if dependency in json_content:
            data[dependency] = json_content[dependency]
        else:
            data[dependency] = get_puppet_information_by_dependency(dependency)

    with open(path, "w") as f:
        json.dump(data, f)

    return data

def get_manifest_documentation(path):
    """
    Get documentation header in manifest file.
    """
    comments = ''

    for line in open(path):
        line = line.rstrip()
        line = line.strip('#')

        if len(line) > 0 and line[0] == ' ':
            line = line[1:]

        if re.compile(r'^class|^define').search(line):
            return comments.strip()

        comments += line + '\n'

def get_manifest_to_markdown(container, documentation, path):
    """
    Convert documentation header in manifest file in markdown.
    """
    content = ''
    line_break = '  '
    space_to_remove = 0

    is_title_found = False
    is_detail_found = False
    is_description_found = False
    is_sample_usage = False

    regex_title = re.compile(r'^Class: |^Define: ')
    regex_detail = re.compile(r'^Variables:|^Requires:|^Vulnerability:|^Sample Usage:')
    regex_sample_usage = re.compile(r'^Sample Usage:')

    for line in documentation.split('\n'):
        if regex_title.search(line):
            is_title_found = True
            title = regex_title.sub('', line)
            content += '### [' + title + '](' + path + ')\n'

        elif regex_detail.search(line):
            if is_title_found and not is_detail_found:
                is_detail_found = True
                content += '<details><summary>Show detail</summary>\n\n'

            if not regex_sample_usage.search(line) and is_sample_usage:
                is_sample_usage = False
                space_to_remove = 0
                content = content.strip() + '\n'
                content += '```\n\n'

            content += '#### ' + regex_detail.search(line).group() + '\n'

            if regex_sample_usage.search(line):
                is_sample_usage = True
                content += '```puppet\n'

        else:
            if is_title_found and not is_detail_found and line != '':
                is_description_found = True

            if is_sample_usage and not space_to_remove:
                space_to_remove = get_space_before(line)

            if len(line) == 0:
                content += '\n'
            else:
                content += line[space_to_remove:] + line_break + '\n'


    if is_sample_usage:
        content = content.strip() + '\n'
        content += '```\n\n'

    content += '<br/>'
    content += '\n\n'
    content += '</details>'

    if not is_title_found:
        print('No title found in ' + path)
        return container

    if not is_description_found:
        print('No description found in ' + path)
        return container

    container['manifests'] += content + '\n\n';
    container['table-of-contents'] += '- [' + title + '](#' + title.replace('::', '') + ')\n'

    return container

def get_space_before(line):
    """
    Get all spaces before characters in line.
    """
    space_before_string = 0
    for i in line:
        if i == ' ' :
            space_before_string = space_before_string + 1
        else:
            return space_before_string

def get_manifests_files():
    """
    Get all files located in manifests directory.
    """
    main_class = 'manifests/init.pp'
    files = subprocess.getoutput('git ls-files manifests/').split('\n')

    files.sort()
    files.remove(main_class)
    files.insert(0, main_class)

    return files

def get_manifests_content():
    """
    Get content by files located in manifests directory.
    """
    content = {
        'manifests': '',
        'table-of-contents': ''
    }

    for path in get_manifests_files():
        documentation = get_manifest_documentation(path)

        if documentation:
            content = get_manifest_to_markdown(content, documentation, path)

    content['manifests'] = content['manifests'].strip()
    content['manifests'] = replace_last(content['manifests'], '\n\n<br/>', '')

    return content

def get_system_dependencies(dependencies):
    """
    Get FreeBSD dependencies and its informations.
    """
    result = {}

    for dependency in dependencies:
        result[dependency] = get_system_information_by_dependency(dependency)

    return result

def get_system_information_by_dependency(dependency):
    """
    Get pkg information by dependency.
    """
    result = {}
    process = subprocess.getoutput('pkg info ' + dependency)

    regex_comment = re.compile(r"^Comment")
    regex_www = re.compile(r"^WWW")

    for line in process.splitlines():
        if regex_comment.search(line):
            q = line.split(maxsplit=2)
            result['description'] = q[2]

        if regex_www.search(line):
            q = line.split(maxsplit=2)

            if (len(q) == 3):
                result['www'] = q[2]

    return result

def get_dependencies_in_makefile():
    """
    Get all dependencies defined in Makefile.
    """
    dependencies = {}
    variables = make_vars(cmd='gmake -pn', origin='makefile')['makefile']
    references = {
        'freebsd': 'FREEBSD_PACKAGES',
        'puppet': 'PUPPET_PACKAGES'
    }

    for reference in references:
        name = references[reference]
        array = variables[name].split()

        array.sort()
        dependencies[reference] = array

    return dependencies

def get_prerequisites_content(dependencies):
    """
    Get prerequisites content based on array.
    """
    content = ''

    for dependency in dependencies:
        parameters = dependencies[dependency]

        prerequisite = prerequisite_content
        prerequisite = prerequisite.replace('www', parameters['www'])
        prerequisite = prerequisite.replace('description', parameters['description'])
        prerequisite = prerequisite.replace('dependency', dependency)

        content += prerequisite

    return content.strip()

def get_freebsd_version():
    """
    Get FreeBSD version without the patch level number.
    """
    return subprocess.getoutput('freebsd-version').split('-')[0]

def replace_in_documentation(freebsd_version, system_dependencies, puppet_dependencies, manifests_content):
    """
    Replace variables in documentation.
    """
    copyfile('script/template.md', 'README.md')

    file_content = [ line for line in open('README.md') ]

    for line in edit_file('README.md'):
        line = line.replace('[freebsd-version]', freebsd_version)

        if line.startswith('[system-dependencies]'):
            print(system_dependencies)
        elif line.startswith('[puppet-dependencies]'):
            print(puppet_dependencies)
        elif line.startswith('[manifests-content]'):
            print(manifests_content['manifests'])
        elif line.startswith('[manifests-table-of-contents]'):
            print(manifests_content['table-of-contents'])
        else:
            print(line)

def main():
    """
    This function is the main executor.
    """
    dependencies = get_dependencies_in_makefile()
    system_dependencies = get_system_dependencies(dependencies['freebsd'])
    puppet_dependencies = get_puppet_dependencies(dependencies['puppet'])

    freebsd_version = get_freebsd_version()
    system_dependencies_content = get_prerequisites_content(system_dependencies)
    puppet_dependencies_content = get_prerequisites_content(puppet_dependencies)
    manifests_content = get_manifests_content()

    replace_in_documentation(
        freebsd_version,
        system_dependencies_content,
        puppet_dependencies_content,
        manifests_content
    )


if __name__ == '__main__':
    main()
