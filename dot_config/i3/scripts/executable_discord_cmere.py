#!/usr/bin/env python3
"""
brings discord to the current workspace to facilitate sharing windows.

this script attempts to work as a toggle.
if discord is on another workspace, float it and bring it here.
if discord is on this workspace, send it to the home workspace and tile it.
"""
from i3ipc import Connection

DISCORD_HOME_WORKSPACE = "2"

bring_commands = []


def main() -> None:
    i3 = Connection()

    try:
        discord = i3.get_tree().find_classed("discord").pop()
    except IndexError:
        print("failed to find discord")
        return

    discord_ws = discord.workspace()
    if not discord_ws:
        print("failed to find discord's workspace")
        return

    if focused := i3.get_tree().find_focused():
        focused_ws = focused.workspace()
    else:
        print("failed to find focused window")
        return

    if not focused_ws:
        print("failed to find focused workspace")

    if discord_ws.name != focused_ws.name:
        print("discord is on another workspace, bringing it here")
        discord.command("floating enable")
        discord.command("resize set 1280 800")
        discord.command(f"move to workspace {focused_ws.name}")
        discord.command("move position center")
        discord.command("focus")
    else:
        print("discord is on this workspace, sending back to 2")
        discord.command(f"move to workspace {DISCORD_HOME_WORKSPACE}")
        discord.command("floating disable")


if __name__ == "__main__":
    main()
