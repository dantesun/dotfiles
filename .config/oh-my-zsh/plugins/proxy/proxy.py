#!/usr/bin/env python3
import os
import sys
from subprocess import check_output, list2cmdline

cwd = os.path.dirname(__file__)

def get_http_proxy():
    default_proxy = os.environ.get("DEFAULT_PROXY")
    if default_proxy:
        return default_proxy
    raise Exception("Not found, Proxy configuration")


def make_proxies(url: str):
    proxies = {"%s_PROXY" % _: url for _ in ("HTTP", "HTTPS", "FTP", "RSYNC", "ALL")}
    proxies.update({name.lower(): value for (name, value) in proxies.items()})
    return proxies


def merge(mapping: dict):
    return ("%s=http://%s" % _ for _ in mapping.items())


class CommandSet:
    proxies = make_proxies(get_http_proxy())

    def enable(self):
        cmdline("export", *merge(self.proxies))

    def disable(self):
        cmdline("unset", *self.proxies.keys())

    def status(self):
        proxies = (
            "%11s = %s" % (name, os.environ[name])
            for name in self.proxies.keys()
            if name in os.environ
        )
        for _ in proxies:
            cmdline("echo", _)

    def usage(self):
        cmdline("echo", "usage: proxy {enable,disable,status}")
        self.status()

def cmdline(*items):
    print(list2cmdline(items))


def main():
    command = CommandSet()
    if len(sys.argv) == 1:
        command.usage()
        sys.exit(-1)
    getattr(command, sys.argv[1], command.usage)()


if __name__ == "__main__":
    main()
