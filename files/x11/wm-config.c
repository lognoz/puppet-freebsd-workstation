/* Appearance */
static const unsigned int borderpx  = 1;
static const unsigned int snap      = 32;
static const int showbar            = 1;
static const int topbar             = 1;
static const char *fonts[]          = { "Source Code Pro:size=10" };
static const char dmenufont[]       = "Source Code Pro:size=10";
static const char col_gray1[]       = "#000000";
static const char col_gray2[]       = "#000000";
static const char col_gray3[]       = "#D8D8D8";
static const char col_gray4[]       = "#FFFFFF";
static const char col_cyan[]        = "#000000";
static const char *colors[][3]      = {
  [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
  [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* Tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6" };
static const Rule rules[] = {
	/* Class      Instance    Title     Tags       Isfloating   Monitor */
	{ "Emacs",    NULL,       NULL,     0,         0,           -1 },
	{ "Firefox",  NULL,       NULL,     2,         0,           -1 },
};

/* Layout(s) */
static const float mfact     = 0.55;
static const int nmaster     = 1;
static const int resizehints = 1;
static const Layout layouts[] = {
	{ "[]=",      tile },
	{ "><>",      NULL },
	{ "[M]",      monocle },
};

/* Key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                         KEY,    view,        {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,             KEY,    toggleview,  {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,               KEY,    tag,         {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask,   KEY,    toggletag,   {.ui = 1 << TAG} },

/* Helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* Commands */
static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
	/* Modifier             Key          Function      Argument */
	{ MODKEY,               XK_p,        spawn,        {.v = dmenucmd } },
	{ MODKEY|ShiftMask,     XK_Return,   spawn,        {.v = termcmd } },
	{ MODKEY|ShiftMask,     XK_c,        killclient,   {0} },
	{ MODKEY,               XK_0,        view,         {.ui = ~0 } },
	{ MODKEY|ShiftMask,     XK_0,        tag,          {.ui = ~0 } },
	{ MODKEY,               XK_comma,    focusmon,     {.i = -1 } },
	{ MODKEY,               XK_period,   focusmon,     {.i = +1 } },
	{ MODKEY|ShiftMask,     XK_comma,    tagmon,       {.i = -1 } },
	{ MODKEY|ShiftMask,     XK_period,   tagmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,     XK_q,        quit,         {0} },
	TAGKEYS(                XK_1,                      0)
	TAGKEYS(                XK_2,                      1)
	TAGKEYS(                XK_3,                      2)
	TAGKEYS(                XK_4,                      3)
	TAGKEYS(                XK_5,                      4)
	TAGKEYS(                XK_6,                      5)
};

static Button buttons[] = {
	/* Click           Event mask    Button      Function         Argument */
	{ ClkLtSymbol,     0,            Button1,    setlayout,       {0} },
	{ ClkLtSymbol,     0,            Button3,    setlayout,       {.v = &layouts[2]} },
	{ ClkWinTitle,     0,            Button2,    zoom,            {0} },
	{ ClkStatusText,   0,            Button2,    spawn,           {.v = termcmd } },
	{ ClkClientWin,    MODKEY,       Button1,    movemouse,       {0} },
	{ ClkClientWin,    MODKEY,       Button2,    togglefloating,  {0} },
	{ ClkClientWin,    MODKEY,       Button3,    resizemouse,     {0} },
	{ ClkTagBar,       0,            Button1,    view,            {0} },
	{ ClkTagBar,       0,            Button3,    toggleview,      {0} },
	{ ClkTagBar,       MODKEY,       Button1,    tag,             {0} },
	{ ClkTagBar,       MODKEY,       Button3,    toggletag,       {0} },
};
