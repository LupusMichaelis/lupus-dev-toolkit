#!/bin/sh

smtp-session()
{
cat << TEST
EHLO $(hostname)
MAIL FROM: <m@lupusmic.org>
RCPT TO: <m@lupusmic.org>
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
