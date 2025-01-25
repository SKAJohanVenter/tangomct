import psycopg2
from psycopg2 import sql

# Function to connect to the PostgreSQL database and list tables in a schema
def list_tables_in_schema(db_config, schema_name):
    """
    Connects to a PostgreSQL database and lists all tables in a given schema.

    Args:
        db_config (dict): A dictionary containing database connection parameters.
        schema_name (str): The name of the schema to query.

    Returns:
        list: A list of table names in the schema.
    """
    try:
        # Connect to the PostgreSQL database
        connection = psycopg2.connect(
            dbname=db_config['dbname'],
            user=db_config['user'],
            password=db_config['password'],
            host=db_config['host'],
            port=db_config['port']
        )
        cursor = connection.cursor()

        # Query to get the list of tables in the specified schema
        query = sql.SQL(
            """
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = %s AND table_type = 'BASE TABLE'
            AND ( 
                starts_with(table_name, 'att_array') OR 
                starts_with(table_name, 'att_image') OR 
                starts_with(table_name, 'att_scalar')  
                )
            ORDER BY table_name;
            """
        )
        cursor.execute(query, (schema_name,))
        tables = cursor.fetchall()

        # Extract table names from query result
        table_names = [table[0] for table in tables]

        return table_names

    except (Exception, psycopg2.Error) as error:
        print("Error while connecting to PostgreSQL:", error)
        return []
    finally:
        # Close the database connection
        if connection:
            cursor.close()
            connection.close()

def generate_view_sql(table_name: str) -> str:
    """Return a string with the SQL to create a view

    :param table_name: The table name
    :type table_name: str
    :return: The SQL to generate the view
    :rtype: str
    """
    return f"""
    CREATE OR RELPACE view view_{table_name} AS
    SELECT attr_type.*, 
       att_conf.att_name, 
       att_conf.cs_name,
       att_conf.domain,
       att_conf.family,
       att_conf.member,
       att_conf.name
        FROM {table_name} AS attr_type 
        INNER JOIN att_conf ON
            attr_type.att_conf_id = att_conf.att_conf_id
    """

# Example usage
if __name__ == "__main__":
    # Database configuration
    db_config = {
        'dbname': 'hdb',
        'user': 'postgres',
        'password': 'password',
        'host': '0.0.0.0',  # or your database host
        'port': '5432'        # default PostgreSQL port
    }
    schema_name = 'public'  # Specify your schema name here

    # Get the list of tables
    tables = list_tables_in_schema(db_config, schema_name)
    for table in tables:
        print(generate_view_sql(table))
        print()
    
