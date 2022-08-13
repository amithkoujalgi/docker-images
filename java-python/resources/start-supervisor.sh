#!/bin/bash
supervisord -c /apps/supervisord.conf
tail -f /logs/supervisord.log