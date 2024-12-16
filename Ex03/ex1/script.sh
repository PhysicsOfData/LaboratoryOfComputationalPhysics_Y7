directory='./students'
file='students_list.csv'
url='https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1'
pod='pod_list.csv'
phys='physics_list.csv'

if [ ! -d "$directory" ]
then
    mkdir $directory
else
    echo "Directory $directory already created"
fi

cd $directory

if [ -f "$file" ]
then 
    echo "File already downloaded"
else
    wget -O $file $url
fi

if [ ! -f "$pod" ]
then
    touch $pod
    grep 'PoD' "$file" > $pod
fi

if [ ! -f "$phys" ]
then
    touch $phys
    grep 'Physics' "$file" > $phys
fi

temp_lett=''
temp_count=0
for L in {A..Z}
do
    pod_count=$(eval grep -c '^$L' "$pod")
    phys_count=$(eval grep -c '^$L' "$phys")
    std_count=$(eval grep -c '^$L' "$file")
    
    echo "In $pod there are $pod_count surnames starting with $L"
    echo "In $phys there are $phys_count surnames starting with $L"

    if [ $temp_count -lt $std_count ]
    then
        temp_lett=$L
        temp_count=$std_count
    fi
done

echo "The most common letter is $temp_lett with an occurrence of $temp_count times"

lines=$(eval wc -l < "$file")
mod18='modulo18'
if [ -d "$mod18" ]; then rm -r $mod18; fi
mkdir $mod18

# sed creates a file by itself
# for (( i=1; i <=18; ++i ))
# do
#     newfile="file_$i"
#     touch $newfile
#     mv $newfile $mod18
# done

for (( i=1; i<=$lines; ++i ))
do
    mod=$(( $i % 19 ))
    sed "${i}q;d" $file >> "$mod18/file_$mod"
done
