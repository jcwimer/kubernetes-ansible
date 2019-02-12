kubectl -n rook-ceph get service | grep 'dashboard-external' | awk {'print $5'} | sed 's/\/TCP//g' | cut -d ':' -f 2
