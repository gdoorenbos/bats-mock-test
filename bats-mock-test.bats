bats_create_mock foo

@test "bats-mock-test function definition" {
    # comment the skip to see the function definition
    skip
    local -r foo_definition=$(declare -f foo)
    echo "foo definition:"
    echo "$foo_definition"
    false
}

@test "bats-mock-test default implementation" {
    run foo
    echo "status: $status"
    echo "output: $output"
    [[ "$status" -eq 0 ]]
    [[ "$output" == "foo" ]]
}

@test "bats-mock-test mock rc" {
    foo_TEST_RC=1
    run foo
    echo "status: $status"
    echo "output: $output"
    [[ "$status" -eq 1 ]]
    [[ "$output" == "foo" ]]
}

@test "bats-mock-test mock output" {
    foo_TEST_OUTPUT="hello, world"
    run foo
    echo "status: $status"
    echo "output: $output"
    [[ "$status" -eq 0 ]]
    [[ "${lines[0]}" == "foo" ]]
    [[ "${lines[1]}" == "hello, world" ]]
    [[ "${#lines[@]}" -eq 2 ]]
}

@test "bats-mock-test mock both rc and output" {
    foo_TEST_RC=2
    foo_TEST_OUTPUT="bar"
    run foo
    echo "status: $status"
    echo "output: $output"
    [[ "$status" -eq 2 ]]
    [[ "${lines[0]}" == "foo" ]]
    [[ "${lines[1]}" == "bar" ]]
    [[ "${#lines[@]}" -eq 2 ]]
}
