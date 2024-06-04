call sp_AddUser("juan","123",2);
call sp_AddUser("pepe","123",2);
call sp_AddUser("carlos","123",2);
call sp_AddUser("jorge","123",2);
call sp_AddUser("kevin","123",2);
call sp_AddUser("Admin","123",1);

call sp_verifyIdentity("juan","123");
call sp_verifyIdentity("Admin","123");