#! /bin/bash
echo "---------------------------"
echo "User Name: 김수호"
echo "Student Number: 12201708"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific
'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item’"
echo "3. Get the average 'rating’ of the movie identified by
specific 'movie id' from 'u.data’"
echo "4. Delete the ‘IMDb URL’ from ‘u.item"
echo "5. Get the data about users from 'u.user’"
echo "6. Modify the format of 'release date' in 'u.item’"
echo "7. Get the data of movies rated by a specific 'user id'
from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with
'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "---------------------------"

while true
	do
		
	read -p "Enter your choice [ 1-9 ] " n

if [ $n -eq 1 ]; then
	read -p "Please enter 'movie id'(1~1682):" x
	response=$(awk -F'|' -v num=$x '$1==num{print $0}' u.item)
	echo "$response"
	

elif [ $n -eq 2 ]; then
	read -p "Do you want to get the data of ‘action’ genre movies
from 'u.item’?(y/n):" x
	if [ "$x" = "y" ]; then
		
		response=$(awk -F'|' -v n=1 -v count=$sum '$7==n{print $1,$2; if (++count == 10) exit}' u.item)
		echo "$response"
	fi
elif [ $n -eq 3 ]; then
	read -p "Please enter the 'movie id’(1~1682):" x
	response=$(awk -v num=$x '$2==num{sum+=$3;count++} END {if(count > 0) print "average rating of", num,": " sum/count;}' u.data)
	echo "$response"
elif [ $n -eq 4 ]; then
	read -p "Do you want to delete the ‘IMDb URL’ from ‘u.item’?(y/n):" x
	if [ "$x" = "y" ]; then
		response=$(awk -F'|' -v count=0 'count < 10 {for(i=1; i<=NF; i++) if(i != 5) printf("%s%s", $i, (i==NF) ? "\n" : "|"); count++}' u.item)
		#response=$(awk -F'|' -v count=0 'count < 10 {$5="";print $0; count++}' u.item)
		echo "$response"
	fi
elif [ $n -eq 5 ]; then
	read -p "Do you want to get the data about users from
‘u.user’?(y/n):" x
	if [ "$x" = "y" ]; then
		response=$(awk -F'|' -v count=0 'count < 10 {printf "user %s is %s years old ", $1, $2;if ($3=="M") printf "male ";if ($3=="F") printf "female ";printf $4;printf "\n";count++}' u.user)
		echo "$response"
	fi
elif [ $n -eq 6 ]; then
	read -p "Do you want to Modify the format of ‘release data’ in ‘u.item’?(y/n):" x
	if [ "$x" = "y" ]; then
		response=$(awk -F'|' -v start=1673 -v end=1682 '{
        if ($1 >= start && $1 <= end) {
            split($3, date, "-");
            month = sprintf("%02d", index("JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC", date[2]) / 3);
            new_date = date[3] month date[1];
            $3 = new_date;
            for (i = 1; i <= NF; i++) {
                printf "%s", $i;
                if (i < NF) {
                    printf "|";
                }
            }
            printf "\n";
        }
    }' u.item)

		#response=$(awk -F'|' -v start=1673 -v end=1682 '$1 >= start && $1 <= end {$3=date +"%Y%m%d";print $0}' u.item)
		#response=$(awk -F'|' -v count=1673 'count < 1682, $1==count{print $0;count++}' u.item)
		echo "$response"
	fi
elif [ $n -eq 7 ]; then
	read -p "Please enter the ‘user id’(1~943):" x
	response=$(awk -v num=$x '$1==num{printf $2;printf "|"}' u.data | tr "|" "\n" | sort -n | tr "\n" "|")
	echo "$response"

	user_numbers=$(awk -v num=$x '$1==num{printf $2; printf "|"}' u.data | tr "|" "\n" | sort -n | head -n 10 | tr "\n" "|")
    response2=$(awk -F'|' -v user_numbers="$user_numbers" 'BEGIN{split(user_numbers, arr, "|"); for (i in arr) user_ids[arr[i]] = 1} $1 in user_ids {printf $1; printf "|"; printf $2;printf "\n"}' u.item)
	
	echo "$response2"
elif [ $n -eq 8 ]; then
	read -p "Do you want to get the average 'rating' of
movies rated by users with 'age' between 20 and
29 and 'occupation' as 'programmer'?(y/n):" x
	if [ "$x" = "y" ]; then

		programmer_users=$(awk -F'|' '$4=="programmer" && $2>=20 && $2<=29{printf $1;printf "|"}' u.user)
		
		echo "$programmer_users"
		
		#programmer_data=$(awk -F'|' -v p_u="$programmer_users" 'BEGIN{if 
		

#		programmer_users=$(awk -F'|' '$4 == "programmer" && $2 >= 20 && $2 <= 29{printf $1; printf "|"}' u.user)
#		echo "$programmer_users"
#		response=$(awk -F'|' -v programmer_users="$programmer_users" 'BEGIN{split(programmer_users, arr, "|"); for (i in arr) programmer_users_arr[arr[i]] = 1} $1 in programmer_users_arr {print $0}' u.data)
		#echo "$responsenrk
	fi
	
elif [ $n -eq 9 ]; then
	echo "Bye!"
	break
fi
done

exit 0

