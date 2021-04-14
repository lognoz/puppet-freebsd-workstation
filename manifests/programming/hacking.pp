# Class: workstation::programming::hacking
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming::hacking
#
class workstation::programming::hacking {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    # This program is a network software suite consisting of a
    # detector, packet sniffer, WEP and WPA/WPA2-PSK cracker and
    # analysis tool.
    'aircrack-ng',

    # This program is used for network troubleshooting, analysis,
    # software and communications protocol development, and education.
    'wireshark',

    # This program is used to discover hosts and services on a
    # computer network by sending packets and analyzing the responses.
    'nmap',

    # This program assists system administrators and security
    # professionals with scanning a system and its security defenses,
    # with the final goal being system hardening.
    'lynis',

    # Hydra works by using different approaches to perform brute-force
    # attacks in order to guess the right username and password
    # combination.
    'hydra',

    # The Metasploit Project is a computer security project that
    # provides information about security vulnerabilities and aids in
    # penetration testing and IDS signature development.
    'metasploit',

    # Burp Scanner is a web application security scanner, used for
    # performing automated vulnerability scans of web applications.
    'burp-devel',

    # Snort's open-source network-based intrusion detection/prevention
    # system (IDS/IPS) has the ability to perform real-time traffic
    # analysis and packet logging on Internet Protocol (IP) networks.
    'snort',

    # It is among the most frequently used password testing and
    # breaking programs as it combines a number of password crackers
    # into one package, autodetects password hash types, and includes
    # a customizable cracker.
    'john',

    # It is capable of performing a variety of transformations such as
    # linearization (also known as web optimization or fast web
    # viewing), encryption, and decryption of PDF files.
    'qpdf'
  ]: }
}
