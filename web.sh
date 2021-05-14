#!/bin/bash
IFS= read -d '' -n 1 orderString 
while IFS= read -d '' -n 1 -t 1 c
do
    orderString+=$c
done

echo '';

read orderNum;
echo '<head>' > downloads/web-orders/$orderNum.html; 
echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">' >> downloads/web-orders/$orderNum.html;
echo "<title>$orderNum</title>" >> downloads/web-orders/$orderNum.html;
echo '<head>' >> downloads/web-orders/$orderNum.html;
echo "<div> Web Order #$orderNum</div>" >> downloads/web-orders/$orderNum.html;
echo '<ol>' >> downloads/web-orders/$orderNum.html;
for sapNum in ${orderString[@]};do
 echo  "<li><a target='_blank' href='https://praktiker.bg/bg/bg/Stolove/TRAPEZEN-STOL-LILOVI-KROS-2-VENGE/p/$sapNum'>$sapNum</a></li><br>" >> downloads/web-orders/$orderNum.html;

done
echo '</ol>' >> downloads/web-orders/$orderNum.html;
