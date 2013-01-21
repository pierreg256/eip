eip
===

Re-attach your elastic IP at every boot

This script, correctly placed in your startup scripts collection, will help you re-attach your elastic ip at every boot of your AWS instance.
The Elastic IP will be placed in the user data section of your instance to make your boot sequence easier.

# How to configure your instance to run with the script

in your console, start the "launch instance" wizard.

# How to install your script #

Connect to your instance : 

    $ ssh ec2-user@ec2-12-34-56-78.eu-west-1.compute.amazonaws.com
  

Clone the repo containing the script

    $ git clone https://github.com/pierreg256/eip.git

Add a call to the script in your startup script sequence. For that open the rc.local script

    $ cd /etc.rc.d
    $ sudo vi rc.local
    
and add the following line : 

    su - ec2-user /home/ec2-user/eip/auto-ip.sh 
    
make sure your script is executable

    $ cd /home/ec2-user/eip
    $ chmod +x auto-ip.sh
    

# Author #

Written by Pierre Gilot - [Twitter](https://twitter.com/pierreg256).

# License #

The MIT License : http://opensource.org/licenses/MIT

Copyright &copy; 2012 Pierre Gilot

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
