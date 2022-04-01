import cx_Oracle
#cx_Oracle.init_oracle_client(lib_dir=r"your path to Oracle client")
database = "@itc3260.acgadmin.edu:1521/orcl"
username = input("Username: ")
password = input("Password: ")
connection_string = username + "/" + password + database
connected = 1
try:
    cx_Oracle.init_oracle_client(lib_dir=r"C:\Programs\oracleClient")
    #connection = cx_Oracle.connect('hr/oracle@itc3260.acgadmin.edu:1521/orcl')
    connection = cx_Oracle.connect(connection_string)
    #print("Login to ", loginInfo, " was successful")
except:
    print("Login failed.")
    connected = 0

def get_headers(ipt):
    headers = []
    select_arr = ipt.strip()
    select_arr = ipt.split(" ")
    item = ""
    for j in range(1, len(select_arr)):
        item = select_arr[j].lower()
        if item=="from":
            break
        else:
            if select_arr[j+1].lower()!="from":
                item = item[0:len(item)-1]
            if item!="select":
                headers.append(item)
    return headers

def print_query(headings, query_output):
    print("Printing Query...")
    output = ""
    for i in range(0, len(headings)):
        if i==0:
            output += headings[i].upper()
        else:
            output += "\t" + headings[i].upper()
    output += "\n"

    for row in (query_output):
        for idx in range(0, len(row)):
            if idx==0:
                output += str(row[idx])
            else:
                output += "\t\t" + str(row[idx])
        output += "\n"
    output = output[0:len(output)-1]
    print(output)

if connected:
    # Always define your connection cursor to be able to fetch data from the db
    cursor = connection.cursor()

    # How to select data from the database
    # Define and execute your select statement
    select_statement = "SELECT employee_id, last_name, first_name, salary FROM dara_emp"

    labels = get_headers(select_statement)
    print(labels)
    results = cursor.execute(select_statement)

    print_query(labels, results)

#TODO: Run "pip install cx_Oracle"
