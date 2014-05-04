#include "share/atspre_staload.hats"

%{^
  #define get_vram() ((void *) 0xB8000)
%}

typedef cell = @{ ch = char, attrib = uint8 }

extern fun get_vram ():<> [l: agz] (@[cell][80*25] @ l | ptr l) = "mac#get_vram"

extern prfun eat_vram {l: agz} {n: int} (pf: @[cell][n] @ l): void

extern castfn uint8_of {n: nat} (i: int n): uint8 n

implement main0 () =
let
  val (pf_vram | vram) = get_vram ()
  var i: int
in
  begin
    for* {i: nat | i <= 80*25} .<80*25 - i>. (i: int i)
    => (i := 0; i < 80*25; i := i + 1)
      vram->[i] := @{ ch = '\0', attrib = uint8_of 192 };
  end;
  let prval () = eat_vram pf_vram in () end
end
