#!/bin/bash
# ==========================================================
# Simple Interest Calculator in Bash
# Formula: Simple Interest = (Principal * Rate * Time) / 100
# ==========================================================

echo "========================================="
echo "        Simple Interest Calculator       "
echo "========================================="

# 1. Take user input
read -p "Enter Principal amount       : " principal
read -p "Enter Rate of interest (in %): " rate
read -p "Enter Time period (in years) : " time

# 2. Input validation: check for valid positive numbers/floats
number_regex='^[0-9]+(\.[0-9]+)?$'
if ! [[ "$principal" =~ $number_regex ]] || \
   ! [[ "$rate" =~ $number_regex ]] || \
   ! [[ "$time" =~ $number_regex ]]; then
    echo "Error: Invalid input. Please enter positive numbers only."
    exit 1
fi

# 3. Calculate Simple Interest using bc (supporting decimals)
if command -v bc >/dev/null 2>&1; then
    interest=$(echo "scale=2; ($principal * $rate * $time) / 100" | bc)
    total=$(echo "scale=2; $principal + $interest" | bc)
else
    # Fallback integer arithmetic if bc is not available
    p_int=${principal%.*}
    r_int=${rate%.*}
    t_int=${time%.*}
    interest=$(( (p_int * r_int * t_int) / 100 ))
    total=$(( p_int + interest ))
fi

# 4. Display results
echo "-----------------------------------------"
echo "Principal       : $principal"
echo "Rate            : $rate %"
echo "Time            : $time year(s)"
echo "-----------------------------------------"
echo "Simple Interest : $interest"
echo "Total Amount    : $total"
echo "========================================="
