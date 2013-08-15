import os
import sys
import shutil
import zipfile
import xml.etree.ElementTree as ET
from urllib.request import urlopen, urlretrieve
import subprocess

if len(sys.argv) == 1:
    print('Usage:')
    print('python android-studio-update.py your_android_studio_path')
    sys.exit()

studio_path = sys.argv[1]
resource_file = studio_path + "/lib/resources.jar"

#os.mkdir('temp')
shutil.copy(resource_file, 'temp')

resource_jar = zipfile.ZipFile('temp/resources.jar')
resource_jar.extractall('temp/')

application_info = ET.parse('temp/idea/AndroidStudioApplicationInfo.xml')
current_build = application_info.find('build').get('number').split('-')[-1]

update_page_response = urlopen('https://dl.google.com/android/studio/patches/updates.xml')
update_page_html = update_page_response.read()
latest_build = ET.fromstring(update_page_html).find('product').find('channel').find('build').get('number')

if float(current_build) < float(latest_build):
    print('Find new version! Latest build = %s, current build = %s' % (latest_build, current_build))

    patch_url = 'http://dl.google.com/android/studio/patches/AI-%s-%s-patch-unix.jar' % (current_build, latest_build)
    urlretrieve(patch_url, 'temp/patch.jar')

    print('Download done!')
    print('Installing...')

    subprocess.call(['java', '-classpath', 'temp/patch.jar', 'com.intellij.updater.Runner', 'install', studio_path])
else:
    print('Current build is latest')
#os.rmtree('temp')
