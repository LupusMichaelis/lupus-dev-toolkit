#!/bin/sh

cid_file=run/container.id
image=lupusmichaelis/elm

[ -d run ] || mkdir run

main()
{
	case $1 in
		build)
			docker build -t $image  .
		;;
		restart)
			stop
			start
		;;
		start)
			start
		;;
		stop)
			stop
		;;
		status)
			container_status
		;;
	esac
}

start()
{
	if [ ! -f $cid_file ]; then
		touch $cid_file || exit 1
	fi

	case $(container_status) in
		exited|running)
			docker start $(container_id)
		;;
		*)
			docker run -v $PWD:/home/mickael/workshop -idt $image > run/container.id
		;;
	esac

	docker attach $(container_id)
}

stop()
{
	if [ container_exists ];
	then
		docker stop $(container_id)
		docker rm $(container_id)
		> run/container.id
	fi
}

container_id()
{
	cat run/container.id
}

container_exists()
{
	local exists=$(false)
	local cid=$(container_id)
	
	if [ ! -z $cid ]
	then
		exists=$(docker ps -qa --no-trunc | grep $cid | wc -l)
	fi

	return $exists
}

container_status()
{
	local status

	if [ -z "$(container_id)" ]
	then
		status=unknown
	elif [ container_exists ]
	then
		status=$(docker inspect --format '{{ .State.Status }}' $(container_id))
	else
		status=unknown
	fi

	echo $status
}

main $@
