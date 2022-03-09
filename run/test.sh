#!/bin/bash
 
echo $0
 
full_path=$(realpath $0)
echo $full_path
 
dir_path=$(dirname $(realpath $0))
echo $dir_path
