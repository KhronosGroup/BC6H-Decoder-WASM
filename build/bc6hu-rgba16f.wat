(module
 (type $i32_i32_i32_=>_none (func (param i32 i32 i32)))
 (type $i32_i32_=>_i32 (func (param i32 i32) (result i32)))
 (import "env" "memory" (memory $0 0))
 (global $assembly/decoder/firstRun (mut i32) (i32.const 1))
 (export "memory" (memory $0))
 (export "decode" (func $assembly/decoder/decode))
 (func $assembly/decoder/decodeBlock (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $17 i32)
  (local $18 i64)
  (local $19 i32)
  (local $20 i32)
  (local $21 i32)
  (local $22 i32)
  (local $23 i32)
  (local $24 i32)
  (local $25 i32)
  local.get $0
  i64.load offset=8
  local.set $18
  local.get $0
  i64.load
  local.tee $6
  i64.const 3
  i64.and
  i64.const 3
  i64.eq
  if
   local.get $6
   i32.wrap_i64
   local.set $4
   local.get $6
   i64.const 32
   i64.shr_u
   i32.wrap_i64
   local.set $0
   local.get $18
   i32.wrap_i64
   local.set $12
   block $break|0
    block $case3|0
     block $case2|0
      block $case1|0
       block $case0|0
        local.get $6
        i32.wrap_i64
        i32.const 31
        i32.and
        i32.const 3
        i32.sub
        br_table $case0|0 $break|0 $break|0 $break|0 $case1|0 $break|0 $break|0 $break|0 $case2|0 $break|0 $break|0 $break|0 $case3|0 $break|0
       end
       local.get $4
       i32.const 5
       i32.shr_u
       i32.const 1023
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=2080
       local.set $9
       local.get $4
       i32.const 15
       i32.shr_u
       i32.const 1023
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=2080
       local.set $13
       local.get $6
       i64.const 25
       i64.shr_u
       i64.const 1023
       i64.and
       i32.wrap_i64
       i32.const 1
       i32.shl
       i32.load16_u offset=2080
       local.set $10
       local.get $0
       i32.const 3
       i32.shr_u
       i32.const 1023
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=2080
       local.set $14
       local.get $0
       i32.const 13
       i32.shr_u
       i32.const 1023
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=2080
       local.set $15
       local.get $12
       i32.const 9
       i32.shl
       i32.const 512
       i32.and
       local.get $0
       i32.const 23
       i32.shr_u
       i32.or
       i32.const 1
       i32.shl
       i32.load16_u offset=2080
       local.set $11
       br $break|0
      end
      local.get $0
      i32.const 2
      i32.shr_u
      i32.const 1024
      i32.and
      local.get $4
      i32.const 5
      i32.shr_u
      i32.const 1023
      i32.and
      i32.or
      local.tee $11
      i32.const 1
      i32.shl
      i32.load16_u offset=4128
      local.set $9
      local.get $0
      i32.const 12
      i32.shr_u
      i32.const 1024
      i32.and
      local.get $4
      i32.const 15
      i32.shr_u
      i32.const 1023
      i32.and
      i32.or
      local.tee $4
      i32.const 1
      i32.shl
      i32.load16_u offset=4128
      local.set $13
      local.get $6
      i64.const 25
      i64.shr_u
      i64.const 1023
      i64.and
      i32.wrap_i64
      local.get $12
      i32.const 10
      i32.shl
      i32.const 1024
      i32.and
      i32.or
      local.tee $12
      i32.const 1
      i32.shl
      i32.load16_u offset=4128
      local.set $10
      local.get $11
      local.get $0
      i32.const 3
      i32.shr_u
      i32.const 23
      i32.shl
      i32.const 23
      i32.shr_s
      i32.add
      i32.const 2047
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=4128
      local.set $14
      local.get $4
      local.get $0
      i32.const 13
      i32.shr_u
      i32.const 23
      i32.shl
      i32.const 23
      i32.shr_s
      i32.add
      i32.const 2047
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=4128
      local.set $15
      local.get $12
      local.get $0
      i32.const 23
      i32.shr_u
      i32.const 23
      i32.shl
      i32.const 23
      i32.shr_s
      i32.add
      i32.const 2047
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=4128
      local.set $11
      br $break|0
     end
     local.get $4
     i32.const 5
     i32.shr_u
     i32.const 1023
     i32.and
     local.get $0
     i32.const 2048
     i32.and
     local.get $0
     i32.const 2
     i32.shr_u
     i32.const 1024
     i32.and
     i32.or
     i32.or
     local.tee $11
     i32.const 1
     i32.shl
     i32.load16_u offset=8224
     local.set $9
     local.get $4
     i32.const 15
     i32.shr_u
     i32.const 1023
     i32.and
     local.get $0
     i32.const 10
     i32.shr_u
     i32.const 2048
     i32.and
     local.get $0
     i32.const 12
     i32.shr_u
     i32.const 1024
     i32.and
     i32.or
     i32.or
     local.tee $4
     i32.const 1
     i32.shl
     i32.load16_u offset=8224
     local.set $13
     local.get $6
     i64.const 25
     i64.shr_u
     i64.const 1023
     i64.and
     i32.wrap_i64
     local.get $0
     i32.const 20
     i32.shr_u
     i32.const 2048
     i32.and
     local.get $12
     i32.const 10
     i32.shl
     i32.const 1024
     i32.and
     i32.or
     i32.or
     local.tee $12
     i32.const 1
     i32.shl
     i32.load16_u offset=8224
     local.set $10
     local.get $11
     local.get $0
     i32.const 3
     i32.shr_u
     i32.const 24
     i32.shl
     i32.const 24
     i32.shr_s
     i32.add
     i32.const 4095
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=8224
     local.set $14
     local.get $4
     local.get $0
     i32.const 13
     i32.shr_u
     i32.const 24
     i32.shl
     i32.const 24
     i32.shr_s
     i32.add
     i32.const 4095
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=8224
     local.set $15
     local.get $12
     local.get $0
     i32.const 23
     i32.shr_u
     i32.const 24
     i32.shl
     i32.const 24
     i32.shr_s
     i32.add
     i32.const 4095
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=8224
     local.set $11
     br $break|0
    end
    local.get $4
    i32.const 5
    i32.shr_u
    i32.const 1023
    i32.and
    local.get $0
    i32.const 7
    i32.shr_u
    i32.const 63
    i32.and
    i32.load8_u offset=96
    i32.const 10
    i32.shl
    i32.or
    local.tee $9
    local.get $0
    i32.const 3
    i32.shr_u
    i32.const 28
    i32.shl
    i32.const 28
    i32.shr_s
    i32.add
    i32.const 65535
    i32.and
    local.set $14
    local.get $4
    i32.const 15
    i32.shr_u
    i32.const 1023
    i32.and
    local.get $0
    i32.const 17
    i32.shr_u
    i32.const 63
    i32.and
    i32.load8_u offset=96
    i32.const 10
    i32.shl
    i32.or
    local.tee $13
    local.get $0
    i32.const 13
    i32.shr_u
    i32.const 28
    i32.shl
    i32.const 28
    i32.shr_s
    i32.add
    i32.const 65535
    i32.and
    local.set $15
    local.get $6
    i64.const 25
    i64.shr_u
    i64.const 1023
    i64.and
    i32.wrap_i64
    local.get $0
    i32.const 27
    i32.shr_u
    i32.load8_u offset=96
    local.get $12
    i32.const 1
    i32.and
    i32.or
    i32.const 10
    i32.shl
    i32.or
    local.tee $10
    local.get $0
    i32.const 23
    i32.shr_u
    i32.const 28
    i32.shl
    i32.const 28
    i32.shr_s
    i32.add
    i32.const 65535
    i32.and
    local.set $11
   end
   local.get $18
   i64.const -16
   i64.and
   local.get $18
   i64.const 1
   i64.shr_u
   i64.const 7
   i64.and
   i64.or
   local.set $6
   local.get $9
   i32.const 6
   i32.shl
   i32.const 32
   i32.add
   local.set $0
   local.get $13
   i32.const 6
   i32.shl
   i32.const 32
   i32.add
   local.set $4
   local.get $10
   i32.const 6
   i32.shl
   i32.const 32
   i32.add
   local.set $12
   local.get $14
   local.get $9
   i32.sub
   local.set $9
   local.get $15
   local.get $13
   i32.sub
   local.set $13
   local.get $11
   local.get $10
   i32.sub
   local.set $11
   loop $for-loop|19
    local.get $3
    i32.const 4
    i32.lt_s
    if
     local.get $1
     local.get $0
     local.get $9
     local.get $6
     i32.wrap_i64
     i32.const 15
     i32.and
     i32.load8_u
     local.tee $10
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     local.get $12
     local.get $10
     local.get $11
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 32
     i64.shl
     i64.const 4323455642275676160
     i64.or
     local.get $4
     local.get $10
     local.get $13
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 16
     i64.shl
     i64.or
     i64.or
     i64.store
     local.get $1
     local.get $12
     local.get $11
     local.get $6
     i64.const 4
     i64.shr_u
     local.tee $6
     i32.wrap_i64
     i32.const 15
     i32.and
     i32.load8_u
     local.tee $10
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 32
     i64.shl
     i64.const 4323455642275676160
     i64.or
     local.get $4
     local.get $10
     local.get $13
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 16
     i64.shl
     i64.or
     local.get $0
     local.get $9
     local.get $10
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.or
     i64.store offset=8
     local.get $1
     local.get $12
     local.get $11
     local.get $6
     i64.const 4
     i64.shr_u
     local.tee $6
     i32.wrap_i64
     i32.const 15
     i32.and
     i32.load8_u
     local.tee $10
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 32
     i64.shl
     i64.const 4323455642275676160
     i64.or
     local.get $4
     local.get $10
     local.get $13
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 16
     i64.shl
     i64.or
     local.get $0
     local.get $9
     local.get $10
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.or
     i64.store offset=16
     local.get $1
     local.get $12
     local.get $11
     local.get $6
     i64.const 4
     i64.shr_u
     local.tee $6
     i32.wrap_i64
     i32.const 15
     i32.and
     i32.load8_u
     local.tee $10
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 32
     i64.shl
     i64.const 4323455642275676160
     i64.or
     local.get $4
     local.get $10
     local.get $13
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 16
     i64.shl
     i64.or
     local.get $0
     local.get $9
     local.get $10
     i32.mul
     i32.add
     i32.const 6
     i32.shr_u
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.or
     i64.store offset=24
     local.get $6
     i64.const 4
     i64.shr_u
     local.set $6
     local.get $1
     local.get $2
     i32.add
     local.set $1
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $for-loop|19
    end
   end
  else
   local.get $1
   local.set $3
   local.get $6
   i32.wrap_i64
   local.set $1
   local.get $6
   i64.const 32
   i64.shr_u
   i32.wrap_i64
   local.set $0
   local.get $18
   i32.wrap_i64
   local.set $4
   block $break|20
    block $case9|20
     block $case8|20
      block $case7|20
       block $case6|20
        block $case5|20
         block $case4|20
          block $case3|20
           block $case2|20
            block $case1|20
             block $case0|20
              local.get $6
              i32.wrap_i64
              i32.const 31
              i32.const 3
              local.get $6
              i64.const 2
              i64.and
              i64.const 0
              i64.ne
              select
              i32.and
              br_table $case0|20 $case1|20 $case2|20 $break|20 $break|20 $break|20 $case3|20 $break|20 $break|20 $break|20 $case4|20 $break|20 $break|20 $break|20 $case5|20 $break|20 $break|20 $break|20 $case6|20 $break|20 $break|20 $break|20 $case7|20 $break|20 $break|20 $break|20 $case8|20 $break|20 $break|20 $break|20 $case9|20 $break|20
             end
             local.get $1
             i32.const 5
             i32.shr_u
             i32.const 1023
             i32.and
             local.tee $7
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $12
             local.get $1
             i32.const 15
             i32.shr_u
             i32.const 1023
             i32.and
             local.tee $8
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $16
             local.get $6
             i64.const 25
             i64.shr_u
             i64.const 1023
             i64.and
             i32.wrap_i64
             local.tee $5
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $11
             local.get $7
             local.get $0
             i32.const 3
             i32.shr_u
             i32.const 27
             i32.shl
             i32.const 27
             i32.shr_s
             i32.add
             i32.const 1023
             i32.and
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $15
             local.get $8
             local.get $0
             i32.const 13
             i32.shr_u
             i32.const 27
             i32.shl
             i32.const 27
             i32.shr_s
             i32.add
             i32.const 1023
             i32.and
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $14
             local.get $5
             local.get $0
             i32.const 23
             i32.shr_u
             i32.const 27
             i32.shl
             i32.const 27
             i32.shr_s
             i32.add
             i32.const 1023
             i32.and
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $10
             local.get $7
             local.get $4
             i32.const 1
             i32.shr_u
             i32.const 27
             i32.shl
             i32.const 27
             i32.shr_s
             i32.add
             i32.const 1023
             i32.and
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $13
             local.get $8
             local.get $1
             i32.const 2
             i32.shl
             i32.const 16
             i32.and
             local.get $0
             i32.const 9
             i32.shr_u
             i32.const 15
             i32.and
             i32.or
             i32.const 27
             i32.shl
             i32.const 27
             i32.shr_s
             i32.add
             i32.const 1023
             i32.and
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $9
             local.get $5
             local.get $1
             i32.const 1
             i32.shl
             i32.const 16
             i32.and
             local.get $4
             i32.const 3
             i32.shl
             i32.const 8
             i32.and
             i32.or
             local.get $0
             i32.const 29
             i32.shr_u
             i32.or
             i32.const 27
             i32.shl
             i32.const 27
             i32.shr_s
             i32.add
             i32.const 1023
             i32.and
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $17
             local.get $7
             local.get $4
             i32.const 7
             i32.shr_u
             i32.const 27
             i32.shl
             i32.const 27
             i32.shr_s
             i32.add
             i32.const 1023
             i32.and
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $7
             local.get $8
             local.get $0
             i32.const 4
             i32.shr_u
             i32.const 16
             i32.and
             local.get $0
             i32.const 19
             i32.shr_u
             i32.const 15
             i32.and
             i32.or
             i32.const 27
             i32.shl
             i32.const 27
             i32.shr_s
             i32.add
             i32.const 1023
             i32.and
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $8
             local.get $5
             local.get $0
             i32.const 18
             i32.shr_u
             i32.const 1
             i32.and
             local.get $0
             i32.const 27
             i32.shr_u
             i32.const 2
             i32.and
             local.get $4
             i32.const 4
             i32.shr_u
             i32.const 4
             i32.and
             local.get $1
             i32.const 16
             i32.and
             local.get $4
             i32.const 9
             i32.shr_u
             i32.const 8
             i32.and
             i32.or
             i32.or
             i32.or
             i32.or
             i32.const 27
             i32.shl
             i32.const 27
             i32.shr_s
             i32.add
             i32.const 1023
             i32.and
             i32.const 1
             i32.shl
             i32.load16_u offset=2080
             local.set $5
             br $break|20
            end
            local.get $1
            i32.const 5
            i32.shr_u
            i32.const 127
            i32.and
            local.tee $7
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $12
            local.get $1
            i32.const 15
            i32.shr_u
            i32.const 127
            i32.and
            local.tee $8
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $16
            local.get $1
            i32.const 25
            i32.shr_u
            local.tee $5
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $11
            local.get $7
            local.get $0
            i32.const 3
            i32.shr_u
            i32.const 26
            i32.shl
            i32.const 26
            i32.shr_s
            i32.add
            i32.const 127
            i32.and
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $15
            local.get $8
            local.get $0
            i32.const 13
            i32.shr_u
            i32.const 26
            i32.shl
            i32.const 26
            i32.shr_s
            i32.add
            i32.const 127
            i32.and
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $14
            local.get $5
            local.get $0
            i32.const 23
            i32.shr_u
            i32.const 26
            i32.shl
            i32.const 26
            i32.shr_s
            i32.add
            i32.const 127
            i32.and
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $10
            local.get $7
            local.get $4
            i32.const 1
            i32.shr_u
            i32.const 26
            i32.shl
            i32.const 26
            i32.shr_s
            i32.add
            i32.const 127
            i32.and
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $13
            local.get $8
            local.get $0
            i32.const 9
            i32.shr_u
            i32.const 15
            i32.and
            local.get $1
            i32.const 3
            i32.shl
            i32.const 32
            i32.and
            local.get $1
            i32.const 20
            i32.shr_u
            i32.const 16
            i32.and
            i32.or
            i32.or
            i32.const 26
            i32.shl
            i32.const 26
            i32.shr_s
            i32.add
            i32.const 127
            i32.and
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $9
            local.get $5
            local.get $4
            i32.const 3
            i32.shl
            i32.const 8
            i32.and
            local.get $1
            i32.const 17
            i32.shr_u
            i32.const 32
            i32.and
            local.get $1
            i32.const 10
            i32.shr_u
            i32.const 16
            i32.and
            i32.or
            i32.or
            local.get $0
            i32.const 29
            i32.shr_u
            i32.or
            i32.const 26
            i32.shl
            i32.const 26
            i32.shr_s
            i32.add
            i32.const 127
            i32.and
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $17
            local.get $7
            local.get $4
            i32.const 7
            i32.shr_u
            i32.const 26
            i32.shl
            i32.const 26
            i32.shr_s
            i32.add
            i32.const 127
            i32.and
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $7
            local.get $8
            local.get $1
            i32.const 1
            i32.shl
            i32.const 48
            i32.and
            local.get $0
            i32.const 19
            i32.shr_u
            i32.const 15
            i32.and
            i32.or
            i32.const 26
            i32.shl
            i32.const 26
            i32.shr_s
            i32.add
            i32.const 127
            i32.and
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $8
            local.get $5
            local.get $1
            i32.const 12
            i32.shr_u
            i32.const 3
            i32.and
            local.get $1
            i32.const 21
            i32.shr_u
            i32.const 4
            i32.and
            local.get $0
            i32.const 3
            i32.shl
            i32.const 8
            i32.and
            local.get $0
            i32.const 4
            i32.shl
            i32.const 32
            i32.and
            local.get $0
            i32.const 2
            i32.shl
            i32.const 16
            i32.and
            i32.or
            i32.or
            i32.or
            i32.or
            i32.const 26
            i32.shl
            i32.const 26
            i32.shr_s
            i32.add
            i32.const 127
            i32.and
            i32.const 1
            i32.shl
            i32.load16_u offset=288
            local.set $5
            br $break|20
           end
           local.get $0
           i32.const 2
           i32.shl
           i32.const 1024
           i32.and
           local.get $1
           i32.const 5
           i32.shr_u
           i32.const 1023
           i32.and
           i32.or
           local.tee $7
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $12
           local.get $0
           i32.const 7
           i32.shr_u
           i32.const 1024
           i32.and
           local.get $1
           i32.const 15
           i32.shr_u
           i32.const 1023
           i32.and
           i32.or
           local.tee $1
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $16
           local.get $6
           i64.const 25
           i64.shr_u
           i64.const 1023
           i64.and
           i32.wrap_i64
           local.get $0
           i32.const 17
           i32.shr_u
           i32.const 1024
           i32.and
           i32.or
           local.tee $5
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $11
           local.get $7
           local.get $0
           i32.const 3
           i32.shr_u
           i32.const 27
           i32.shl
           i32.const 27
           i32.shr_s
           i32.add
           i32.const 2047
           i32.and
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $15
           local.get $1
           local.get $0
           i32.const 13
           i32.shr_u
           i32.const 28
           i32.shl
           i32.const 28
           i32.shr_s
           i32.add
           i32.const 2047
           i32.and
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $14
           local.get $5
           local.get $0
           i32.const 23
           i32.shr_u
           i32.const 28
           i32.shl
           i32.const 28
           i32.shr_s
           i32.add
           i32.const 2047
           i32.and
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $10
           local.get $7
           local.get $4
           i32.const 1
           i32.shr_u
           i32.const 27
           i32.shl
           i32.const 27
           i32.shr_s
           i32.add
           i32.const 2047
           i32.and
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $13
           local.get $1
           local.get $0
           i32.const 9
           i32.shr_u
           i32.const 28
           i32.shl
           i32.const 28
           i32.shr_s
           i32.add
           i32.const 2047
           i32.and
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $9
           local.get $5
           local.get $4
           i32.const 3
           i32.shl
           i32.const 8
           i32.and
           local.get $0
           i32.const 29
           i32.shr_u
           i32.or
           i32.const 28
           i32.shl
           i32.const 28
           i32.shr_s
           i32.add
           i32.const 2047
           i32.and
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $17
           local.get $7
           local.get $4
           i32.const 7
           i32.shr_u
           i32.const 27
           i32.shl
           i32.const 27
           i32.shr_s
           i32.add
           i32.const 2047
           i32.and
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $7
           local.get $1
           local.get $0
           i32.const 19
           i32.shr_u
           i32.const 28
           i32.shl
           i32.const 28
           i32.shr_s
           i32.add
           i32.const 2047
           i32.and
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $8
           local.get $5
           local.get $0
           i32.const 18
           i32.shr_u
           i32.const 1
           i32.and
           local.get $0
           i32.const 27
           i32.shr_u
           i32.const 2
           i32.and
           local.get $4
           i32.const 9
           i32.shr_u
           i32.const 8
           i32.and
           local.get $4
           i32.const 4
           i32.shr_u
           i32.const 4
           i32.and
           i32.or
           i32.or
           i32.or
           i32.const 28
           i32.shl
           i32.const 28
           i32.shr_s
           i32.add
           i32.const 2047
           i32.and
           i32.const 1
           i32.shl
           i32.load16_u offset=4128
           local.set $5
           br $break|20
          end
          local.get $6
          i64.const 29
          i64.shr_u
          i64.const 1024
          i64.and
          local.get $6
          i64.const 5
          i64.shr_u
          i64.const 1023
          i64.and
          i64.or
          i32.wrap_i64
          local.tee $1
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $12
          local.get $6
          i64.const 40
          i64.shr_u
          i64.const 1024
          i64.and
          local.get $6
          i64.const 15
          i64.shr_u
          i64.const 1023
          i64.and
          i64.or
          i32.wrap_i64
          local.tee $8
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $16
          local.get $6
          i64.const 49
          i64.shr_u
          i64.const 1024
          i64.and
          local.get $6
          i64.const 25
          i64.shr_u
          i64.const 1023
          i64.and
          i64.or
          i32.wrap_i64
          local.tee $5
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $11
          local.get $1
          local.get $0
          i32.const 3
          i32.shr_u
          i32.const 28
          i32.shl
          i32.const 28
          i32.shr_s
          i32.add
          i32.const 2047
          i32.and
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $15
          local.get $8
          local.get $0
          i32.const 13
          i32.shr_u
          i32.const 27
          i32.shl
          i32.const 27
          i32.shr_s
          i32.add
          i32.const 2047
          i32.and
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $14
          local.get $5
          local.get $0
          i32.const 23
          i32.shr_u
          i32.const 28
          i32.shl
          i32.const 28
          i32.shr_s
          i32.add
          i32.const 2047
          i32.and
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $10
          local.get $1
          local.get $4
          i32.const 1
          i32.shr_u
          i32.const 28
          i32.shl
          i32.const 28
          i32.shr_s
          i32.add
          i32.const 2047
          i32.and
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $13
          local.get $8
          local.get $4
          i32.const 7
          i32.shr_u
          local.tee $7
          i32.const 16
          i32.and
          local.get $0
          i32.const 9
          i32.shr_u
          i32.const 15
          i32.and
          i32.or
          i32.const 27
          i32.shl
          i32.const 27
          i32.shr_s
          i32.add
          i32.const 2047
          i32.and
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $9
          local.get $5
          local.get $4
          i32.const 3
          i32.shl
          i32.const 8
          i32.and
          local.get $0
          i32.const 29
          i32.shr_u
          i32.or
          i32.const 28
          i32.shl
          i32.const 28
          i32.shr_s
          i32.add
          i32.const 2047
          i32.and
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $17
          local.get $1
          local.get $7
          i32.const 28
          i32.shl
          i32.const 28
          i32.shr_s
          i32.add
          i32.const 2047
          i32.and
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $7
          local.get $8
          local.get $0
          i32.const 4
          i32.shr_u
          i32.const 16
          i32.and
          local.get $0
          i32.const 19
          i32.shr_u
          i32.const 15
          i32.and
          i32.or
          i32.const 27
          i32.shl
          i32.const 27
          i32.shr_s
          i32.add
          i32.const 2047
          i32.and
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $8
          local.get $5
          local.get $4
          i32.const 5
          i32.shr_u
          i32.const 1
          i32.and
          local.get $0
          i32.const 27
          i32.shr_u
          i32.const 2
          i32.and
          local.get $4
          i32.const 9
          i32.shr_u
          i32.const 8
          i32.and
          local.get $4
          i32.const 4
          i32.shr_u
          i32.const 4
          i32.and
          i32.or
          i32.or
          i32.or
          i32.const 28
          i32.shl
          i32.const 28
          i32.shr_s
          i32.add
          i32.const 2047
          i32.and
          i32.const 1
          i32.shl
          i32.load16_u offset=4128
          local.set $5
          br $break|20
         end
         local.get $0
         i32.const 3
         i32.shl
         i32.const 1024
         i32.and
         local.get $1
         i32.const 5
         i32.shr_u
         i32.const 1023
         i32.and
         i32.or
         local.tee $7
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $12
         local.get $0
         i32.const 7
         i32.shr_u
         i32.const 1024
         i32.and
         local.get $1
         i32.const 15
         i32.shr_u
         i32.const 1023
         i32.and
         i32.or
         local.tee $1
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $16
         local.get $6
         i64.const 25
         i64.shr_u
         i64.const 1023
         i64.and
         i32.wrap_i64
         local.get $0
         i32.const 18
         i32.shr_u
         local.tee $19
         i32.const 1024
         i32.and
         i32.or
         local.tee $5
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $11
         local.get $7
         local.get $0
         i32.const 3
         i32.shr_u
         i32.const 28
         i32.shl
         i32.const 28
         i32.shr_s
         i32.add
         i32.const 2047
         i32.and
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $15
         local.get $1
         local.get $0
         i32.const 13
         i32.shr_u
         i32.const 28
         i32.shl
         i32.const 28
         i32.shr_s
         i32.add
         i32.const 2047
         i32.and
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $14
         local.get $5
         local.get $0
         i32.const 23
         i32.shr_u
         i32.const 27
         i32.shl
         i32.const 27
         i32.shr_s
         i32.add
         i32.const 2047
         i32.and
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $10
         local.get $7
         local.get $4
         i32.const 1
         i32.shr_u
         i32.const 28
         i32.shl
         i32.const 28
         i32.shr_s
         i32.add
         i32.const 2047
         i32.and
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $13
         local.get $1
         local.get $0
         i32.const 9
         i32.shr_u
         i32.const 28
         i32.shl
         i32.const 28
         i32.shr_s
         i32.add
         i32.const 2047
         i32.and
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $9
         local.get $5
         local.get $0
         i32.const 4
         i32.shr_u
         i32.const 16
         i32.and
         local.get $4
         i32.const 3
         i32.shl
         i32.const 8
         i32.and
         i32.or
         local.get $0
         i32.const 29
         i32.shr_u
         i32.or
         i32.const 27
         i32.shl
         i32.const 27
         i32.shr_s
         i32.add
         i32.const 2047
         i32.and
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $17
         local.get $7
         local.get $4
         i32.const 7
         i32.shr_u
         local.tee $20
         i32.const 28
         i32.shl
         i32.const 28
         i32.shr_s
         i32.add
         i32.const 2047
         i32.and
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $7
         local.get $1
         local.get $0
         i32.const 19
         i32.shr_u
         i32.const 28
         i32.shl
         i32.const 28
         i32.shr_s
         i32.add
         i32.const 2047
         i32.and
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $8
         local.get $5
         local.get $19
         i32.const 1
         i32.and
         local.get $4
         i32.const 4
         i32.shr_u
         i32.const 6
         i32.and
         local.get $20
         i32.const 16
         i32.and
         local.get $4
         i32.const 9
         i32.shr_u
         i32.const 8
         i32.and
         i32.or
         i32.or
         i32.or
         i32.const 27
         i32.shl
         i32.const 27
         i32.shr_s
         i32.add
         i32.const 2047
         i32.and
         i32.const 1
         i32.shl
         i32.load16_u offset=4128
         local.set $5
         br $break|20
        end
        local.get $1
        i32.const 5
        i32.shr_u
        i32.const 511
        i32.and
        local.tee $7
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $12
        local.get $1
        i32.const 15
        i32.shr_u
        i32.const 511
        i32.and
        local.tee $8
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $16
        local.get $6
        i64.const 25
        i64.shr_u
        i64.const 511
        i64.and
        i32.wrap_i64
        local.tee $5
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $11
        local.get $7
        local.get $0
        i32.const 3
        i32.shr_u
        i32.const 27
        i32.shl
        i32.const 27
        i32.shr_s
        i32.add
        i32.const 511
        i32.and
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $15
        local.get $8
        local.get $0
        i32.const 13
        i32.shr_u
        i32.const 27
        i32.shl
        i32.const 27
        i32.shr_s
        i32.add
        i32.const 511
        i32.and
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $14
        local.get $5
        local.get $0
        i32.const 23
        i32.shr_u
        i32.const 27
        i32.shl
        i32.const 27
        i32.shr_s
        i32.add
        i32.const 511
        i32.and
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $10
        local.get $7
        local.get $4
        i32.const 1
        i32.shr_u
        i32.const 27
        i32.shl
        i32.const 27
        i32.shr_s
        i32.add
        i32.const 511
        i32.and
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $13
        local.get $8
        local.get $1
        i32.const 20
        i32.shr_u
        i32.const 16
        i32.and
        local.get $0
        i32.const 9
        i32.shr_u
        i32.const 15
        i32.and
        i32.or
        i32.const 27
        i32.shl
        i32.const 27
        i32.shr_s
        i32.add
        i32.const 511
        i32.and
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $9
        local.get $5
        local.get $1
        i32.const 10
        i32.shr_u
        i32.const 16
        i32.and
        local.get $4
        i32.const 3
        i32.shl
        i32.const 8
        i32.and
        i32.or
        local.get $0
        i32.const 29
        i32.shr_u
        i32.or
        i32.const 27
        i32.shl
        i32.const 27
        i32.shr_s
        i32.add
        i32.const 511
        i32.and
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $17
        local.get $7
        local.get $4
        i32.const 7
        i32.shr_u
        i32.const 27
        i32.shl
        i32.const 27
        i32.shr_s
        i32.add
        i32.const 511
        i32.and
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $7
        local.get $8
        local.get $0
        i32.const 4
        i32.shr_u
        i32.const 16
        i32.and
        local.get $0
        i32.const 19
        i32.shr_u
        i32.const 15
        i32.and
        i32.or
        i32.const 27
        i32.shl
        i32.const 27
        i32.shr_s
        i32.add
        i32.const 511
        i32.and
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $8
        local.get $5
        local.get $0
        i32.const 18
        i32.shr_u
        i32.const 1
        i32.and
        local.get $0
        i32.const 27
        i32.shr_u
        i32.const 2
        i32.and
        local.get $4
        i32.const 4
        i32.shr_u
        i32.const 4
        i32.and
        local.get $0
        i32.const 2
        i32.shl
        i32.const 16
        i32.and
        local.get $4
        i32.const 9
        i32.shr_u
        i32.const 8
        i32.and
        i32.or
        i32.or
        i32.or
        i32.or
        i32.const 27
        i32.shl
        i32.const 27
        i32.shr_s
        i32.add
        i32.const 511
        i32.and
        i32.const 1
        i32.shl
        i32.load16_u offset=1056
        local.set $5
        br $break|20
       end
       local.get $1
       i32.const 5
       i32.shr_u
       i32.const 255
       i32.and
       local.tee $7
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $12
       local.get $1
       i32.const 15
       i32.shr_u
       i32.const 255
       i32.and
       local.tee $8
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $16
       local.get $6
       i64.const 25
       i64.shr_u
       i64.const 255
       i64.and
       i32.wrap_i64
       local.tee $5
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $11
       local.get $7
       local.get $0
       i32.const 3
       i32.shr_u
       i32.const 26
       i32.shl
       i32.const 26
       i32.shr_s
       i32.add
       i32.const 255
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $15
       local.get $8
       local.get $0
       i32.const 13
       i32.shr_u
       i32.const 27
       i32.shl
       i32.const 27
       i32.shr_s
       i32.add
       i32.const 255
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $14
       local.get $5
       local.get $0
       i32.const 23
       i32.shr_u
       i32.const 27
       i32.shl
       i32.const 27
       i32.shr_s
       i32.add
       i32.const 255
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $10
       local.get $7
       local.get $4
       i32.const 1
       i32.shr_u
       i32.const 26
       i32.shl
       i32.const 26
       i32.shr_s
       i32.add
       i32.const 255
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $13
       local.get $8
       local.get $1
       i32.const 20
       i32.shr_u
       i32.const 16
       i32.and
       local.get $0
       i32.const 9
       i32.shr_u
       i32.const 15
       i32.and
       i32.or
       i32.const 27
       i32.shl
       i32.const 27
       i32.shr_s
       i32.add
       i32.const 255
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $9
       local.get $5
       local.get $1
       i32.const 10
       i32.shr_u
       i32.const 16
       i32.and
       local.get $4
       i32.const 3
       i32.shl
       i32.const 8
       i32.and
       i32.or
       local.get $0
       i32.const 29
       i32.shr_u
       i32.or
       i32.const 27
       i32.shl
       i32.const 27
       i32.shr_s
       i32.add
       i32.const 255
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $17
       local.get $7
       local.get $4
       i32.const 7
       i32.shr_u
       i32.const 26
       i32.shl
       i32.const 26
       i32.shr_s
       i32.add
       i32.const 255
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $7
       local.get $8
       local.get $1
       i32.const 9
       i32.shr_u
       i32.const 16
       i32.and
       local.get $0
       i32.const 19
       i32.shr_u
       i32.const 15
       i32.and
       i32.or
       i32.const 27
       i32.shl
       i32.const 27
       i32.shr_s
       i32.add
       i32.const 255
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $8
       local.get $5
       local.get $0
       i32.const 18
       i32.shr_u
       i32.const 1
       i32.and
       local.get $0
       i32.const 27
       i32.shr_u
       i32.const 2
       i32.and
       local.get $0
       i32.const 2
       i32.shl
       i32.const 24
       i32.and
       local.get $1
       i32.const 21
       i32.shr_u
       i32.const 4
       i32.and
       i32.or
       i32.or
       i32.or
       i32.const 27
       i32.shl
       i32.const 27
       i32.shr_s
       i32.add
       i32.const 255
       i32.and
       i32.const 1
       i32.shl
       i32.load16_u offset=544
       local.set $5
       br $break|20
      end
      local.get $1
      i32.const 5
      i32.shr_u
      i32.const 255
      i32.and
      local.tee $7
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $12
      local.get $1
      i32.const 15
      i32.shr_u
      i32.const 255
      i32.and
      local.tee $8
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $16
      local.get $6
      i64.const 25
      i64.shr_u
      i64.const 255
      i64.and
      i32.wrap_i64
      local.tee $5
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $11
      local.get $7
      local.get $0
      i32.const 3
      i32.shr_u
      i32.const 27
      i32.shl
      i32.const 27
      i32.shr_s
      i32.add
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $15
      local.get $8
      local.get $0
      i32.const 13
      i32.shr_u
      i32.const 26
      i32.shl
      i32.const 26
      i32.shr_s
      i32.add
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $14
      local.get $5
      local.get $0
      i32.const 23
      i32.shr_u
      i32.const 27
      i32.shl
      i32.const 27
      i32.shr_s
      i32.add
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $10
      local.get $7
      local.get $4
      i32.const 1
      i32.shr_u
      i32.const 27
      i32.shl
      i32.const 27
      i32.shr_s
      i32.add
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $13
      local.get $8
      local.get $0
      i32.const 9
      i32.shr_u
      i32.const 15
      i32.and
      local.get $1
      i32.const 18
      i32.shr_u
      i32.const 32
      i32.and
      local.get $1
      i32.const 20
      i32.shr_u
      i32.const 16
      i32.and
      i32.or
      i32.or
      i32.const 26
      i32.shl
      i32.const 26
      i32.shr_s
      i32.add
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $9
      local.get $5
      local.get $1
      i32.const 10
      i32.shr_u
      i32.const 16
      i32.and
      local.get $4
      i32.const 3
      i32.shl
      i32.const 8
      i32.and
      i32.or
      local.get $0
      i32.const 29
      i32.shr_u
      i32.or
      i32.const 27
      i32.shl
      i32.const 27
      i32.shr_s
      i32.add
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $17
      local.get $7
      local.get $4
      i32.const 7
      i32.shr_u
      i32.const 27
      i32.shl
      i32.const 27
      i32.shr_s
      i32.add
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $7
      local.get $8
      local.get $0
      i32.const 19
      i32.shr_u
      i32.const 15
      i32.and
      local.get $0
      i32.const 4
      i32.shl
      i32.const 32
      i32.and
      local.get $0
      i32.const 4
      i32.shr_u
      i32.const 16
      i32.and
      i32.or
      i32.or
      i32.const 26
      i32.shl
      i32.const 26
      i32.shr_s
      i32.add
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $8
      local.get $5
      local.get $1
      i32.const 13
      i32.shr_u
      i32.const 1
      i32.and
      local.get $0
      i32.const 27
      i32.shr_u
      i32.const 2
      i32.and
      local.get $4
      i32.const 4
      i32.shr_u
      i32.const 4
      i32.and
      local.get $0
      i32.const 2
      i32.shl
      i32.const 16
      i32.and
      local.get $4
      i32.const 9
      i32.shr_u
      i32.const 8
      i32.and
      i32.or
      i32.or
      i32.or
      i32.or
      i32.const 27
      i32.shl
      i32.const 27
      i32.shr_s
      i32.add
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      i32.load16_u offset=544
      local.set $5
      br $break|20
     end
     local.get $1
     i32.const 5
     i32.shr_u
     i32.const 255
     i32.and
     local.tee $7
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $12
     local.get $1
     i32.const 15
     i32.shr_u
     i32.const 255
     i32.and
     local.tee $8
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $16
     local.get $6
     i64.const 25
     i64.shr_u
     i64.const 255
     i64.and
     i32.wrap_i64
     local.tee $5
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $11
     local.get $7
     local.get $0
     i32.const 3
     i32.shr_u
     i32.const 27
     i32.shl
     i32.const 27
     i32.shr_s
     i32.add
     i32.const 255
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $15
     local.get $8
     local.get $0
     i32.const 13
     i32.shr_u
     i32.const 27
     i32.shl
     i32.const 27
     i32.shr_s
     i32.add
     i32.const 255
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $14
     local.get $5
     local.get $0
     i32.const 23
     i32.shr_u
     i32.const 26
     i32.shl
     i32.const 26
     i32.shr_s
     i32.add
     i32.const 255
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $10
     local.get $7
     local.get $4
     i32.const 1
     i32.shr_u
     i32.const 27
     i32.shl
     i32.const 27
     i32.shr_s
     i32.add
     i32.const 255
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $13
     local.get $8
     local.get $1
     i32.const 20
     i32.shr_u
     i32.const 16
     i32.and
     local.get $0
     i32.const 9
     i32.shr_u
     i32.const 15
     i32.and
     i32.or
     i32.const 27
     i32.shl
     i32.const 27
     i32.shr_s
     i32.add
     i32.const 255
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $9
     local.get $5
     local.get $4
     i32.const 3
     i32.shl
     i32.const 8
     i32.and
     local.get $1
     i32.const 18
     i32.shr_u
     i32.const 32
     i32.and
     local.get $1
     i32.const 10
     i32.shr_u
     i32.const 16
     i32.and
     i32.or
     i32.or
     local.get $0
     i32.const 29
     i32.shr_u
     i32.or
     i32.const 26
     i32.shl
     i32.const 26
     i32.shr_s
     i32.add
     i32.const 255
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $17
     local.get $7
     local.get $4
     i32.const 7
     i32.shr_u
     i32.const 27
     i32.shl
     i32.const 27
     i32.shr_s
     i32.add
     i32.const 255
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $7
     local.get $8
     local.get $0
     i32.const 4
     i32.shr_u
     i32.const 16
     i32.and
     local.get $0
     i32.const 19
     i32.shr_u
     i32.const 15
     i32.and
     i32.or
     i32.const 27
     i32.shl
     i32.const 27
     i32.shr_s
     i32.add
     i32.const 255
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $8
     local.get $5
     local.get $0
     i32.const 18
     i32.shr_u
     i32.const 1
     i32.and
     local.get $1
     i32.const 12
     i32.shr_u
     i32.const 2
     i32.and
     local.get $4
     i32.const 4
     i32.shr_u
     i32.const 4
     i32.and
     local.get $4
     i32.const 9
     i32.shr_u
     i32.const 8
     i32.and
     local.get $0
     i32.const 4
     i32.shl
     i32.const 32
     i32.and
     local.get $0
     i32.const 2
     i32.shl
     i32.const 16
     i32.and
     i32.or
     i32.or
     i32.or
     i32.or
     i32.or
     i32.const 26
     i32.shl
     i32.const 26
     i32.shr_s
     i32.add
     i32.const 255
     i32.and
     i32.const 1
     i32.shl
     i32.load16_u offset=544
     local.set $5
     br $break|20
    end
    local.get $1
    i32.const 5
    i32.shr_u
    i32.const 63
    i32.and
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $12
    local.get $1
    i32.const 15
    i32.shr_u
    i32.const 63
    i32.and
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $16
    local.get $1
    i32.const 25
    i32.shr_u
    i32.const 63
    i32.and
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $11
    local.get $0
    i32.const 3
    i32.shr_u
    i32.const 63
    i32.and
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $15
    local.get $0
    i32.const 13
    i32.shr_u
    i32.const 63
    i32.and
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $14
    local.get $0
    i32.const 23
    i32.shr_u
    i32.const 63
    i32.and
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $10
    local.get $4
    i32.const 1
    i32.shr_u
    i32.const 63
    i32.and
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $13
    local.get $0
    i32.const 9
    i32.shr_u
    i32.const 15
    i32.and
    local.get $1
    i32.const 16
    i32.shr_u
    i32.const 32
    i32.and
    local.get $1
    i32.const 20
    i32.shr_u
    i32.const 16
    i32.and
    i32.or
    i32.or
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $9
    local.get $4
    i32.const 3
    i32.shl
    i32.const 8
    i32.and
    local.get $1
    i32.const 17
    i32.shr_u
    i32.const 32
    i32.and
    local.get $1
    i32.const 10
    i32.shr_u
    i32.const 16
    i32.and
    i32.or
    i32.or
    local.get $0
    i32.const 29
    i32.shr_u
    i32.or
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $17
    local.get $4
    i32.const 7
    i32.shr_u
    i32.const 63
    i32.and
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $7
    local.get $0
    i32.const 19
    i32.shr_u
    i32.const 15
    i32.and
    local.get $1
    i32.const 26
    i32.shr_u
    i32.const 32
    i32.and
    local.get $1
    i32.const 7
    i32.shr_u
    i32.const 16
    i32.and
    i32.or
    i32.or
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $8
    local.get $1
    i32.const 12
    i32.shr_u
    i32.const 3
    i32.and
    local.get $1
    i32.const 21
    i32.shr_u
    i32.const 4
    i32.and
    local.get $0
    i32.const 3
    i32.shl
    i32.const 8
    i32.and
    local.get $0
    i32.const 4
    i32.shl
    i32.const 32
    i32.and
    local.get $0
    i32.const 2
    i32.shl
    i32.const 16
    i32.and
    i32.or
    i32.or
    i32.or
    i32.or
    i32.const 1
    i32.shl
    i32.load16_u offset=160
    local.set $5
   end
   local.get $18
   i64.const 18
   i64.shr_u
   i64.const 3
   i64.and
   i64.const -1
   block $assembly/decoder/getAnchor|inlined.0 (result i32)
    i32.const 15
    local.get $18
    i64.const 13
    i64.shr_u
    i32.wrap_i64
    i32.const 31
    i32.and
    local.tee $1
    i32.const 16
    i32.lt_u
    br_if $assembly/decoder/getAnchor|inlined.0
    drop
    i64.const 2488276740032571439
    local.get $1
    i32.const 15
    i32.and
    i32.const 2
    i32.shl
    i64.extend_i32_u
    i64.shr_s
    i32.wrap_i64
    i32.const 15
    i32.and
   end
   i32.const 3
   i32.mul
   local.tee $0
   i32.const 3
   i32.add
   i64.extend_i32_u
   i64.shl
   local.get $18
   i64.const 16
   i64.shr_u
   i64.and
   i64.const -1
   i64.const 65
   local.get $0
   i64.extend_i32_u
   i64.sub
   i64.shr_u
   i64.const 3
   i64.shl
   local.get $18
   i64.const 17
   i64.shr_u
   i64.and
   i64.or
   i64.or
   local.set $6
   local.get $12
   i32.const 6
   i32.shl
   i32.const 32
   i32.add
   local.set $19
   local.get $16
   i32.const 6
   i32.shl
   i32.const 32
   i32.add
   local.set $20
   local.get $11
   i32.const 6
   i32.shl
   i32.const 32
   i32.add
   local.set $21
   local.get $13
   i32.const 6
   i32.shl
   i32.const 32
   i32.add
   local.set $22
   local.get $9
   i32.const 6
   i32.shl
   i32.const 32
   i32.add
   local.set $23
   local.get $17
   i32.const 6
   i32.shl
   i32.const 32
   i32.add
   local.set $24
   local.get $15
   local.get $12
   i32.sub
   local.set $15
   local.get $14
   local.get $16
   i32.sub
   local.set $14
   local.get $10
   local.get $11
   i32.sub
   local.set $10
   local.get $7
   local.get $13
   i32.sub
   local.set $13
   local.get $8
   local.get $9
   i32.sub
   local.set $12
   local.get $5
   local.get $17
   i32.sub
   local.set $16
   local.get $1
   i32.const 1
   i32.shl
   i32.load16_u offset=32
   local.set $1
   loop $for-loop|141
    local.get $25
    i32.const 4
    i32.lt_s
    if
     local.get $6
     i32.wrap_i64
     i32.const 7
     i32.and
     i32.load8_u offset=16
     local.set $4
     local.get $3
     local.get $1
     i32.const 1
     i32.and
     if (result i32)
      local.get $22
      local.get $4
      local.get $13
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $0
      local.get $23
      local.get $4
      local.get $12
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $9
      local.get $24
      local.get $4
      local.get $16
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
     else
      local.get $19
      local.get $4
      local.get $15
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $0
      local.get $20
      local.get $4
      local.get $14
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $9
      local.get $21
      local.get $4
      local.get $10
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
     end
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 32
     i64.shl
     i64.const 4323455642275676160
     i64.or
     local.get $9
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 16
     i64.shl
     i64.or
     local.get $0
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.or
     i64.store
     local.get $6
     i64.const 3
     i64.shr_u
     local.tee $6
     i32.wrap_i64
     i32.const 7
     i32.and
     i32.load8_u offset=16
     local.set $0
     local.get $3
     local.get $1
     i32.const 1
     i32.shr_u
     local.tee $4
     i32.const 1
     i32.and
     if (result i32)
      local.get $22
      local.get $0
      local.get $13
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $11
      local.get $23
      local.get $0
      local.get $12
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $9
      local.get $24
      local.get $0
      local.get $16
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
     else
      local.get $19
      local.get $0
      local.get $15
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $11
      local.get $20
      local.get $0
      local.get $14
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $9
      local.get $21
      local.get $0
      local.get $10
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
     end
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 32
     i64.shl
     i64.const 4323455642275676160
     i64.or
     local.get $9
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 16
     i64.shl
     i64.or
     local.get $11
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.or
     i64.store offset=8
     local.get $6
     i64.const 3
     i64.shr_u
     local.tee $6
     i32.wrap_i64
     i32.const 7
     i32.and
     i32.load8_u offset=16
     local.set $1
     local.get $3
     local.get $4
     i32.const 1
     i32.shr_u
     local.tee $4
     i32.const 1
     i32.and
     if (result i32)
      local.get $22
      local.get $1
      local.get $13
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $0
      local.get $23
      local.get $1
      local.get $12
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $9
      local.get $24
      local.get $1
      local.get $16
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
     else
      local.get $19
      local.get $1
      local.get $15
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $0
      local.get $20
      local.get $1
      local.get $14
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $9
      local.get $21
      local.get $1
      local.get $10
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
     end
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 32
     i64.shl
     i64.const 4323455642275676160
     i64.or
     local.get $9
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 16
     i64.shl
     i64.or
     local.get $0
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.or
     i64.store offset=16
     local.get $6
     i64.const 3
     i64.shr_u
     local.tee $6
     i32.wrap_i64
     i32.const 7
     i32.and
     i32.load8_u offset=16
     local.set $0
     local.get $3
     local.get $4
     i32.const 1
     i32.shr_u
     local.tee $1
     i32.const 1
     i32.and
     if (result i32)
      local.get $22
      local.get $0
      local.get $13
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $11
      local.get $23
      local.get $0
      local.get $12
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $9
      local.get $24
      local.get $0
      local.get $16
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
     else
      local.get $19
      local.get $0
      local.get $15
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $11
      local.get $20
      local.get $0
      local.get $14
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
      local.set $9
      local.get $21
      local.get $0
      local.get $10
      i32.mul
      i32.add
      i32.const 6
      i32.shr_u
     end
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 32
     i64.shl
     i64.const 4323455642275676160
     i64.or
     local.get $9
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.const 16
     i64.shl
     i64.or
     local.get $11
     i32.const 31
     i32.mul
     i32.const 6
     i32.shr_u
     i64.extend_i32_u
     i64.or
     i64.store offset=24
     local.get $6
     i64.const 3
     i64.shr_u
     local.set $6
     local.get $1
     i32.const 1
     i32.shr_u
     local.set $1
     local.get $2
     local.get $3
     i32.add
     local.set $3
     local.get $25
     i32.const 1
     i32.add
     local.set $25
     br $for-loop|141
    end
   end
  end
 )
 (func $assembly/decoder/decode (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  local.get $0
  local.get $1
  i32.or
  i32.const 0
  i32.lt_s
  if
   i32.const 1
   return
  end
  local.get $1
  i32.const 3
  i32.add
  i32.const 2
  i32.shr_s
  local.tee $10
  local.get $0
  i32.const 3
  i32.add
  i32.const 2
  i32.shr_s
  local.tee $6
  i32.mul
  i32.const 4
  i32.shl
  local.tee $9
  local.get $0
  local.get $10
  i32.const 2
  i32.shl
  i32.mul
  i32.const 3
  i32.shl
  i32.add
  memory.size
  i32.const 1
  i32.sub
  i32.const 16
  i32.shl
  i32.gt_s
  if
   i32.const 1
   return
  end
  global.get $assembly/decoder/firstRun
  if
   i32.const 0
   i64.const 2169069333509637120
   i64.store
   i32.const 8
   i64.const 4628635210004244002
   i64.store
   i32.const 16
   i64.const 4627217879049308416
   i64.store
   i32.const 32
   i64.const -1384594177156133684
   i64.store
   i32.const 40
   i64.const -1404842944515749760
   i64.store
   i32.const 48
   i64.const -1729102426907293696
   i64.store
   i32.const 56
   i64.const -1152640094071357464
   i64.store
   i32.const 64
   i64.const 634568842329126672
   i64.store
   i32.const 72
   i64.const -8300643185197055860
   i64.store
   i32.const 80
   i64.const 3921621964628691084
   i64.store
   i32.const 88
   i64.const 4151317811495442408
   i64.store
   i32.const 96
   i64.const 4042024681196232704
   i64.store
   i32.const 104
   i64.const 4331385372548539396
   i64.store
   i32.const 112
   i64.const 4186705026872386050
   i64.store
   i32.const 120
   i64.const 4476065718224692742
   i64.store
   i32.const 128
   i64.const 4114364854034309377
   i64.store
   i32.const 136
   i64.const 4403725545386616069
   i64.store
   i32.const 144
   i64.const 4259045199710462723
   i64.store
   i32.const 152
   i64.const 4548405891062769415
   i64.store
   i32.const 6
   local.set $2
   i32.const 160
   local.set $3
   loop $for-loop|0
    local.get $2
    i32.const 13
    i32.lt_u
    if
     i32.const 1
     i32.const 15
     local.get $2
     i32.sub
     i32.shl
     local.tee $5
     i32.const 1
     local.get $2
     i32.shl
     local.tee $4
     i32.const 1
     i32.sub
     i32.const 16
     local.get $2
     i32.sub
     i32.shl
     i32.or
     local.set $7
     i32.const 0
     local.set $1
     loop $for-loop|1
      local.get $1
      local.get $4
      i32.lt_u
      if
       local.get $3
       local.get $1
       i32.const 1
       i32.shl
       i32.add
       i32.const 65535
       local.get $1
       i32.const 16
       local.get $2
       i32.sub
       i32.shl
       local.tee $8
       local.get $5
       i32.const 0
       local.get $8
       select
       i32.or
       local.tee $8
       local.get $7
       local.get $8
       i32.eq
       select
       i32.store16
       local.get $1
       i32.const 1
       i32.add
       local.set $1
       br $for-loop|1
      end
     end
     local.get $3
     local.get $4
     i32.const 1
     i32.shl
     i32.add
     local.set $3
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $for-loop|0
    end
   end
   i32.const 0
   global.set $assembly/decoder/firstRun
  end
  local.get $0
  i32.const 2
  i32.shr_s
  local.set $5
  local.get $0
  i32.const 3
  i32.and
  i32.const 3
  i32.shl
  local.tee $7
  local.get $0
  i32.const 3
  i32.shl
  local.tee $4
  i32.const 3
  i32.mul
  i32.add
  local.set $8
  i32.const 16
  i32.const 0
  local.get $7
  select
  local.set $11
  i32.const 65536
  local.set $2
  local.get $9
  i32.const 65536
  i32.add
  local.set $1
  i32.const 0
  local.set $0
  loop $for-loop|2
   local.get $0
   local.get $10
   i32.lt_s
   if
    i32.const 0
    local.set $3
    loop $for-loop|3
     local.get $3
     local.get $5
     i32.lt_s
     if
      local.get $2
      local.get $1
      local.get $4
      call $assembly/decoder/decodeBlock
      local.get $2
      i32.const 16
      i32.add
      local.set $2
      local.get $1
      i32.const 32
      i32.add
      local.set $1
      local.get $3
      i32.const 1
      i32.add
      local.set $3
      br $for-loop|3
     end
    end
    local.get $2
    local.get $11
    i32.add
    local.set $2
    local.get $1
    local.get $8
    i32.add
    local.set $1
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|2
   end
  end
  local.get $7
  if
   local.get $5
   i32.const 4
   i32.shl
   i32.const 65536
   i32.add
   local.set $2
   local.get $9
   i32.const 65536
   i32.add
   local.get $5
   i32.const 5
   i32.shl
   i32.add
   local.set $1
   local.get $6
   i32.const 4
   i32.shl
   local.set $5
   local.get $4
   i32.const 2
   i32.shl
   local.set $9
   i32.const 0
   local.set $3
   loop $for-loop|4
    local.get $3
    local.get $10
    i32.lt_s
    if
     local.get $2
     i32.const 32768
     i32.const 32
     call $assembly/decoder/decodeBlock
     i32.const 0
     local.set $0
     loop $for-loop|5
      local.get $0
      local.get $7
      i32.lt_s
      if
       local.get $0
       local.get $1
       i32.add
       local.get $0
       i64.load offset=32768
       i64.store
       local.get $0
       local.get $1
       local.get $4
       i32.add
       local.tee $6
       i32.add
       local.get $0
       i64.load offset=32800
       i64.store
       local.get $0
       local.get $4
       local.get $6
       i32.add
       local.tee $6
       i32.add
       local.get $0
       i64.load offset=32832
       i64.store
       local.get $0
       local.get $4
       local.get $6
       i32.add
       i32.add
       local.get $0
       i64.load offset=32864
       i64.store
       local.get $0
       i32.const 8
       i32.add
       local.set $0
       br $for-loop|5
      end
     end
     local.get $2
     local.get $5
     i32.add
     local.set $2
     local.get $1
     local.get $9
     i32.add
     local.set $1
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $for-loop|4
    end
   end
  end
  i32.const 0
 )
)
