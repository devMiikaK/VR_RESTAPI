const sqlite3 = require('sqlite3').verbose();
let db = new sqlite3.Database('/Users/miika/sql/databases/test_db.db', sqlite3.OPEN_READWRITE, (err) => {
    if (err) {
        console.error(err.message);
    }
    console.log('Connected.');
});
//process.exit();
let sql = 'select * from Emp where sal > 4500';

 

db.all(sql, [], (err, rows) => {
    if (err) {
        throw err;
    }
    console.table(rows);
});
db.close((err) => {
    if (err) {
        console.error(err.message);
    }
    console.log('Close the database connection.');
});