# toys

## Discription

This is a repo for dealing with Shanghaitech EE111 Class which only provide pdf/docx version homework, which convert it to editable tex file.

## Usage

`./convert.sh path/to/this_time_hw_dir`
Then happly edit the new `*_test.tex`.

## Dependency

awk
For pdf -> tex, you need to install pdftotext and pdfimage; for docx -> tex, you need pandoc.

## Tips

WARNING: This is only a toy. Which means that I do this only for fun. Right now it can only handle 10 question and together with many many other restrictions. I guarantee NOTHING with it, but if you expect other features / some bugs, you're welcome to raise an issue / pull request.

## Thanks

Special thanks for prof. Ziyu Shao, whose hw tex template helps me a lot.
