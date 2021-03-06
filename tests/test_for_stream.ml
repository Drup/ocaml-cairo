open Printf

let make create fname =
  let fh = open_out fname in
  let surface = create ~output:(output_string fh) ~width:100. ~height:100. in
  let ctx = Cairo.create surface in

  Cairo.set_line_width ctx 1.;
  Cairo.move_to ctx 0. 0.;
  Cairo.line_to ctx 100. 100.;
  Cairo.stroke ctx;
  Cairo.Surface.finish surface; (* Important for the data to be written *)
  flush fh;
  close_out fh;
  printf "Wrote %S.\n" fname

let () =
  make Cairo.SVG.create_for_stream "/tmp/cairo-test.svg";
  Gc.major();
  make Cairo.PDF.create_for_stream "/tmp/cairo-test.pdf";
