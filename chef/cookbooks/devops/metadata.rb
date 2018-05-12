name 'devops'
maintainer_email 'cyang0125@outlook.com'
license 'Apache-2.0'
description 'Basic devops module'
version '0.0.1'

chef_version '>= 12.15' if respond_to?(:chef_version)

depends 'poise-python'
depends 'poise-archive'
depends 'poise'
depends "docker"
