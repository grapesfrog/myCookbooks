if  (rs.status()['myState'] ==2) 
{
print("This is a slave");
 db.runCommand({fsync:1,lock:1});
print("locked file system - do something");
runProgram("/etc/chef/mongobackup.sh")
print("Unlock file system");
db.$cmd.sys.unlock.findOne();
db.currentOp();
}
else
{ print("This is a master");
run
}