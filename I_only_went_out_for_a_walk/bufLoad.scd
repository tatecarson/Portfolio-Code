~path = PathName(thisProcess.nowExecutingPath).parentPath ++ "Buffers/";

~makeBuffers = {
  b = Dictionary.new;
  PathName(~path).entries.do{
    arg subfolder;
    b.add(
      subfolder.folderName.asSymbol ->
      Array.fill(
        subfolder.entries.size,
        {
          arg i;
          Buffer.read(s, subfolder.entries[i].fullPath);
        }
      )
    );
  };
};

~makeBuffers.();
