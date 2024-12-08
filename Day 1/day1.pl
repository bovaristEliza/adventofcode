% Advent of Code - Day 1
:- use_module(library(lists)).
% read each line from stream and add to list
read_lines(Stream, [], []) :-
    at_end_of_stream(Stream), !.

read_lines(Stream, [ID1|RestIDsEven], [ID2|RestIDsOdd]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, Codes),
    atom_codes(Atom, Codes),
    atom_string(Atom, Line),
    split_string(Line, " ", " ", [ID1Str, ID2Str]),
    number_string(ID1, ID1Str),
    number_string(ID2, ID2Str),
    read_lines(Stream, RestIDsEven, RestIDsOdd).

take_smaller([], [], []).
take_smaller(List1, List2, [Diff|DiffList]) :-
    min_list(List1, Min1),
    min_list(List2, Min2),
    select(Min1, List1, Rest1),
    select(Min2, List2, Rest2),
    (Min1 > Min2 -> Diff is Min1 - Min2 ; Diff is Min2 - Min1),
    take_smaller(Rest1, Rest2, DiffList).

main :-
    % Open file stream
    open('input.pl', read, Stream),
    % Call the predicate
    read_lines(Stream, IDsEven, IDsOdd),
    % Print the IDs (for debugging purposes)
    %writeln(IDsEven),
    %writeln(IDsOdd),
    %check the smallest number in the first list and second list and calc diff
    take_smaller(IDsEven, IDsOdd, DiffList),
    % summarize the list
    %write(DiffList),
    sum_list(DiffList, Sum),
    writeln(Sum),
    % Close the stream
    close(Stream).

    %ans:2904518