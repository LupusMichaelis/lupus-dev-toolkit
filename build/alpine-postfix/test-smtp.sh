#!/bin/sh

smtp-session()
{
cat << TEST
EHLO $(hostname)
MAIL FROM: <m@lupusmic.org>
RCPT TO: <m.wolff@elpev.com>
DATA
Subject: My test email

Try me out!

.
quit
TEST
}

smtp-test()
{
    smtp-session | telnet $(y d last-ip) smtp
}
