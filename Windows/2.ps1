$a = new-object -comobject wscript.shell
$intAnswer = $a.popup("Do you want to remove these files?", `
0,"Delete Files",4)
If ($intAnswer -eq 6) {
  $a.popup("You answered yes.")
} else {
  $a.popup("You answered no.")
}