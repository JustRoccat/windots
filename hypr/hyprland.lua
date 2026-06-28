
local mod = "SUPER"


local terminal    = "kitty"
local browser     = "zen"
local filemanager = terminal .. " -e yazi"



hl.monitor({ output = "DP-2",     mode = "1920x1080@60",  position = "0x0",    scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@100", position = "1920x0", scale = 1 })


hl.window_rule({ match = { class = "clippy-linux" }, monitor = "HDMI-A-1" })


hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,
        border_size = 3,
        col = {
            active_border   = "rgba(000080ff)",
            inactive_border = "rgba(808080ff)",
        },
        layout = "dwindle",
        resize_on_border = true,
    },

    decoration = {
        rounding = 0,
        active_opacity   = 1.0,
        inactive_opacity = 0.88,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 6,
            render_power = 2,
            color        = "rgba(00000066)",
        },

        blur = {
            enabled = false,
        },
    },

    input = {
        kb_layout = "pl",
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        focus_on_activate        = true,
    },

    animations = {
        enabled = true,
        bezier = {
            v1_dash  = { 0.05, 0.9, 0.1, 1.05 },
            snappy   = { 0.19, 1, 0.22, 1 },
            linear   = { 1, 1, 0, 0 },
        },
        animation = {

            windowsIn        = { 1, 2, "snappy",  "popin 80%" },
            windowsOut       = { 1, 1, "snappy",  "popin 80%" },
            windowsMove      = { 1, 2, "v1_dash" },
            fadeIn           = { 1, 2, "snappy" },
            fadeOut          = { 1, 1, "snappy" },
            fadeSwitch       = { 1, 2, "snappy" },
            workspaces       = { 1, 2, "v1_dash", "slide" },
            specialWorkspace = { 1, 2, "v1_dash", "slidefadevert" },
            border           = { 1, 4, "linear" },
        }
    }
})


hl.bind(mod .. " + Q",             hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F",             hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mod .. " + P",             hl.dsp.window.fullscreen({ mode = "maximized",   action = "toggle" }))


hl.bind(mod .. " + Z", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(filemanager))


hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "d" }))

hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))


hl.bind(mod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))

hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))


hl.bind(mod .. " + CTRL + left",  function() hl.dsp.window.resize({ x = -40, y = 0 }) end)
hl.bind(mod .. " + CTRL + right", function() hl.dsp.window.resize({ x =  40, y = 0 }) end)
hl.bind(mod .. " + CTRL + up",    function() hl.dsp.window.resize({ x = 0, y = -40 }) end)
hl.bind(mod .. " + CTRL + down",  function() hl.dsp.window.resize({ x = 0, y =  40 }) end)

hl.bind(mod .. " + CTRL + H", function() hl.dsp.window.resize({ x = -40, y = 0 }) end)
hl.bind(mod .. " + CTRL + L", function() hl.dsp.window.resize({ x =  40, y = 0 }) end)
hl.bind(mod .. " + CTRL + K", function() hl.dsp.window.resize({ x = 0, y = -40 }) end)
hl.bind(mod .. " + CTRL + J", function() hl.dsp.window.resize({ x = 0, y =  40 }) end)


hl.bind("Print",               hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("sh -c 'hyprshot -m region --clipboard-only'"))


hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end


hl.env("XDG_DATA_DIRS",               os.getenv("HOME") .. "/.local/share:" .. (os.getenv("XDG_DATA_DIRS") or "/usr/local/share:/usr/share"))
hl.env("LD_LIBRARY_PATH",             "/usr/lib64/pipewire-0.3/jack:" .. (os.getenv("LD_LIBRARY_PATH") or ""))
hl.env("ELECTRON_OZONE_PLATFORM_HINT","wayland")
hl.env("XCURSOR_THEME",               "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE",                "24")


hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
    hl.exec_cmd("dbus-update-activation-environment --all")

    hl.exec_cmd("swww-daemon &")
    hl.exec_cmd("sleep 1 && swww img /home/coldbrxthe/Pictures/ultrakill_wallpaper.png")

    hl.exec_cmd("/usr/libexec/xdg-desktop-portal &")
    hl.exec_cmd("gentoo-pipewire-launcher")
    hl.exec_cmd("/usr/libexec/lxqt-policykit-agent")

    hl.exec_cmd("sleep 1 && hyprctl setcursor 'Bibata-Modern-Classic' 24")
    hl.exec_cmd("sleep 1 && gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic'")
    hl.exec_cmd("sleep 1 && gsettings set org.gnome.desktop.interface cursor-size 24")

    hl.exec_cmd("quickshell &")
    hl.exec_cmd("sleep 2 && clippy-linux &")
    hl.exec_cmd("sleep 1 && gsettings set org.gnome.desktop.interface gtk-theme 'Chicago95'")
    hl.exec_cmd("sleep 1 && gsettings set org.gnome.desktop.interface icon-theme 'Chicago95'")
end)
