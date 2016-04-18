Eye.application 'hadoop-jobhistoryserver-{{ env_name }}' do
  working_dir '/etc/eye'
  stdall '/var/log/eye/hadoop-jobhistoryserver-{{ env_name }}-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes
  uid '{{ hadoop_user }}'

  process :jobhistoryserver_{{ env_name }} do
    pid_file '/tmp/mapred-{{ hadoop_user }}-historyserver.pid'
    start_command '{{ hadoop_distr_prefix }}/sbin/mr-jobhistory-daemon.sh start historyserver --config {{ hadoop_distr_prefix }}/conf'

    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
