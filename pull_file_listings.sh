if [[ "$1" = '-h' ]] || [[ "$1" = '--help' ]] || [[ -z "$1" ]] || [[ -z "$2" ]]; then
  echo "Specify the SSH line to connect and output file"
  echo "example: $0 'admin@1.1.1.1' 'Azure_Ubuntu_Server_16.04_LTS'"
  exit 1
else
    target=${1}
    host=$(echo ${1}| cut -d ' ' -f1 | cut -d '@' -f2)
    output_filename=${2}
    username=$(ssh ${target} "whoami")
    ssh ${target} "find / -perm -o+r -type f" > ${output_filename}.${username}_user
    ssh ${target} "sudo find / -perm -o+r -type f" > ${output_filename}.sudo-${username}_user
    #Create user
    ssh ${target} "sudo useradd basicuser -m -p '$1$1Bzaee6b$fPEbflSh9oY8ywTi1vYry0'"
    ssh ${target} "sudo mkdir /home/basicuser/.ssh"
    ssh ${target} "sudo chown ${username} /home/basicuser/.ssh"
    #put your public key in the basicuser's .ssh authorized keys
    ssh ${target} "sudo sh -c \"echo $(cat ~/.ssh/id_rsa.pub) > /home/basicuser/.ssh/authorized_keys\""
    ssh ${target} "sudo chown basicuser /home/basicuser/.ssh"
    ssh ${target} "sudo chown basicuser /home/basicuser/.ssh/authorized_keys"
    ssh basicuser@${host} "find / -perm -o+r -type f" > ${output_filename}.basicuser
fi