#!/bin/sh

test1(){
	echo "this is test1"
}

test2(){
	echo "this is test2"
}

echo "Select which function you want to execute"
echo "test1"
echo "test2"

read func2exec

if [ "$func2exec" = "test1" ]; then
	test1
elif [ "$func2exec" = "test2" ]; then
	test2
else
	echo "Sorry, we don't having anything you want.";
fi