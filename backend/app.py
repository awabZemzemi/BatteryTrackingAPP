import pandas as pd
from flask import Flask,render_template,jsonify
import pymysql
app = Flask(__name__)
#csv
#dataset=pd.read_csv('output.csv')
#database config
db_config = {
    'host': 'localhost',
    'user': 'root',
    'database': 'battery'
}
i=0

connection = pymysql.connect(**db_config)
@app.route('/home_data')
def getHome():
    try:
        # Establish a connection to the MySQL database
        connection = pymysql.connect(**db_config)

        # Execute the SELECT query
        with connection.cursor() as cursor:
            query = f'SELECT * FROM output WHERE `index` = {i} '
            print(f'Executing query: {query}')
            cursor.execute(query)
            result = cursor.fetchall()
            print('hello /n')
            print(result)
            return jsonify({
                'SOC':result[0][1],
                'SOH':result[0][2],
                'Temperature_measured': result[0][5],

                'Time': result[0][8]
            })


    except pymysql.Error as e:
        print(f"Error executing MySQL query: {e}")

    finally:
        connection.close()


@app.route('/details_data')
def getDetails():
    global i
    
    try:
        # Establish a connection to the MySQL database
        connection = pymysql.connect(**db_config)
        i= i+1 if i < 500 else 0

        # Execute the SELECT query
        with connection.cursor() as cursor:
            query = f'SELECT * FROM output WHERE `index` = {i+1} '
            print(f'Executing query: {query}')
            cursor.execute(query)
            result = cursor.fetchall()
            

            return jsonify({
                 'SOC': result[0][1],
                 'SOH': result[0][2],
                 'Voltage_measured': result[0][3],
                 'Current_measured': result[0][4],
                 'Temperature_measured': result[0][5],
                 'Current_charge': result[0][6],
                 'Voltage_charge': result[0][7],
                 'Time': result[0][8]
            })
        

    except pymysql.Error as e:
        print(f"Error executing MySQL query: {e}")

    finally:
        connection.close()


if __name__ == '__main__':
    app.run(debug=True)
