#!/bin/sh

G='\033[0;32m'
R='\033[0;31m'
N='\033[0m'

[ ! -f prog ] && make

fprint() {
	printf "[%s] Test: %-25s\nExpected: %s\nCaptured: %s %b\n\n" "$(date '+%Y-%m-%d %H:%M:%S')" "${1}" "${2}" "${3}" "${4}"
}

test_ackermann() {
	captured=$(./prog ackermann.snl)
	expected="1021"
	[ "${captured}" = "${expected}" ] && {
		fprint "Ackermann(3,7)" "${expected}" "${captured}" "\n${G}PASSED${N}\n";
		return 0;
	} || {
		fprint "Ackermann(3,7)" "${expected}" "${captured}" "\n${R}FAILED${N}\n";
		return 2;
	}
}

test_increment() {
	captured=$(./prog anon_func.snl)
	expected="8"
	[ "${captured}" = "${expected}" ] && {
		fprint "Increment" "${expected}" "${captured}" "\n${G}PASSED${N}\n";
		return 0;
	} || {
		fprint "Increment" "${expected}" "${captured}" "\n${R}FAILED${N}\n";
		return 3;
	}
}

test_core_lang() {
	expected="20\n1\n0\n1\n2\n3\n4\n20\n15\n42"
	expected=$(printf '%b' "${expected}")
	captured=$(./prog core_language_test.snl)
	[ "${captured}" = "${expected}" ] && {
		fprint "Core Language" "${expected}" "${captured}" "\n${G}PASSED${N}\n";
		return 0;
	} || {
		fprint "Core Language" "${expected}" "${captured}" "\n${R}FAILED${N}\n";
		return 4;
	}
}

test_turing() {
	captured=$(./prog turing.snl)
	expected="120"
	[ "${captured}" = "${expected}" ] && {
		fprint "Turing Completeness" "${expected}" "${captured}" "\n${G}PASSED${N}\n";
		return 0;
	} || {
		fprint "Turing Completeness" "${expected}" "${captured}" "\n${R}FAILED${N}\n";
		return 5;
	}
}

test_hof() {
	captured=$(./prog hofac.snl)
	expected="25"
	[ "${captured}" = "${expected}" ] && {
		fprint "Higher Order" "${expected}" "${captured}" "\n${G}PASSED${N}\n";
		return 0;
	} || {
		fprint "Higher Order" "${expected}" "${captured}" "\n${R}FAILED${N}\n";
		return 6;
	}
}

test_recursion() {
	captured=$(./prog recursion.snl)
	expected="120"
	[ "${captured}" = "${expected}" ] && {
		fprint "Recursion" "${expected}" "${captured}" "\n${G}PASSED${N}\n";
		return 0;
	} || { 
		fprint "Recursion" "${expected}" "${captured}" "\n${R}FAILED${N}\n";
		return 7;
	}
}

test_demorgan() {
	expected="true\ntrue\ntrue\ntrue\n"
	expected=$(printf %b "${expected}")
	captured=$(./prog demorgan_law.snl)
	[ "${captured}" = "${expected}" ] && {
		fprint "DeMorgan" "${expected}" "${captured}" "\n${G}PASSED${N}\n";
		return 0;
	} || { 
		fprint "DeMorgan" "${expected}" "${captured}" "\n${R}FAILED${N}\n";
		return 8;
	}
}

test_truth() {
	expected="true\ntrue\ntrue\ntrue\n"
	expected=$(printf %b "${expected}")
	captured=$(./prog truth_table_testing.snl)
	[ "${captured}" = "${expected}" ] && {
		fprint "Truth Table" "${expected}" "${captured}" "\n${G}PASSED${N}\n";
		return 0;
	} || {
		fprint "Truth Table" "${expected}" "${captured}" "\n${R}FAILED${N}\n";
		return 9;
	}
}

test_entscheidungs() {
	captured=$(./prog entscheidungs_problem.snl)
	expected="0"
	[ "${captured}" = "${expected}" ] && {
		fprint "EntscheidungsProblem" "${expected}" "${captured}" "\n${G}CONFIRMED${N}\n";
		return 0;
	} || {
		fprint "EntscheidungsProblem" "${expected}" "${captured}" "\n${R}REFUTED${N}\n";
		return 10;
	}
}

test_halting() {
	captured=$(./prog halting_paradox.snl)
	expected="0"
	[ "${captured}" = "${expected}" ] && {
		fprint "Halting Paradox" "${expected}" "${captured}" "\n${G}CONFIRMED${N}\n";
		return 0;
	} || {
		fprint "Halting Paradox" "${expected}" "${captured}" "\n${R}REFUTED${N}\n";
		return 	11;
	}
}

test_purediag() {
	exec 3>&2 2>/dev/null
	./prog pure_diag.snl
	captured="${?}"
	expected="139"
	exec 2>&3 3>&-
	[ "${captured}" = "${expected}" ] && {
		fprint "Self Reference" "${expected}" "${captured}" "\n${G}CONFIRMED${N}\n";
		return 0;
	} || {
		fprint "Self Reference" "${expected}" "${captured}" "\n${R}REFUTED${N}\n";
		return 	12;
	}
}

{ test_ackermann && test_increment && test_core_lang && test_turing && test_hof && test_recursion && test_demorgan && test_truth && test_entscheidungs && test_halting && test_purediag; ret="${?}"; } || exit 1

[ "${ret}" -eq 0 ] 2>/dev/null || printf "%s\n" "${ret}"
