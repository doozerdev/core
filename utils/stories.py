#!/usr/bin/env python

import xml.etree.ElementTree as ET
from operator import itemgetter
import sys
import re
import os
import pprint

def get_stories(filename):
    file_handle = open(filename, 'r')
    line_count = 1;
    unicode_error = 0;

    for line in file_handle.readlines():
        match = re.search("[\x80-\xFF]",line)
        if (match):
            print "ERROR: Line {} - Non-Unicode Character <{}>".format(line_count,line);
            unicode_error += 1;
        line_count += 1

    if (unicode_error != 0):
        raise Exception("ERROR: Non-Unicode Characters in file [{}]".format(filename))

    stories = []

    parsed_xml = ET.parse(filename)
    elements0 = parsed_xml.getroot().findall('channel')

    for element0 in elements0:
        for element1 in element0:
            if (element1.tag == 'item'):
                item = {}
                for element2 in element1:
                    item[element2.tag] = element2.text
                stories.append(item)

    return stories

def main():

    try:
        filename = sys.argv[1]
    except:
        filename = 'stories.xml'

    stories = get_stories(filename)

    stories = sorted(stories, key=itemgetter('status'))

    print "-" * 80
    print "STORY KEYS"
    for key in stories[0].keys():
        print key

    print "-" * 80
    print "STORIES"
    for story in stories:
        print "[{:>12}] {}".format(story['status'],story['title'])
 
if ('__main__' == __name__):
    main()
