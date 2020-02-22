#!/bin/bash

sheet2csv()
{
    test "$1" ||
    {
        echo "usage: $0 <spreadsheet_file>" >&2
        return 1
    }

    libreoffice --calc --convert-to csv --infilter=CSV:44,34,76,1 --headless "$1"
}
