{
    "metadata": {
        "kernelspec": {
            "name": "SQL",
            "display_name": "SQL",
            "language": "sql"
        },
        "language_info": {
            "name": "sql",
            "version": ""
        }
    },
    "nbformat_minor": 2,
    "nbformat": 4,
    "cells": [
        {
            "cell_type": "markdown",
            "source": [
                "vytvoreno View\\_Duration"
            ],
            "metadata": {
                "azdata_cell_guid": "bed98067-e3d9-4137-b92b-5bb663fa66d6"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "CREATE OR ALTER VIEW dbo.View_Duration AS\r\n",
                "SELECT\r\n",
                "    uc.unique_call_id,\r\n",
                "    MIN(uc.dateTimeConnect) AS dateTimeConnect,\r\n",
                "    MAX(uc.dateTimeDisconnect) AS dateTimeDisconnect,\r\n",
                "    DATEDIFF(SECOND, MIN(uc.dateTimeConnect), MAX(uc.dateTimeDisconnect)) AS duration_seconds,\r\n",
                "    CONVERT(VARCHAR(8), DATEADD(SECOND, DATEDIFF(SECOND, MIN(uc.dateTimeConnect), MAX(uc.dateTimeDisconnect)), 0), 108) AS duration_hhmmss\r\n",
                "FROM dbo.cdr_unique_calls AS uc\r\n",
                "WHERE uc.dateTimeDisconnect IS NOT NULL\r\n",
                "GROUP BY uc.unique_call_id"
            ],
            "metadata": {
                "azdata_cell_guid": "4e2f5455-a4d0-49f2-90e3-6c4cb45ee0ea",
                "language": "sql"
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "markdown",
            "source": [
                "test view\\_duration"
            ],
            "metadata": {
                "azdata_cell_guid": "65cd659c-136b-4b54-8ffb-d2bac3ed75ce"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 10 *\r\n",
                "FROM dbo.View_Duration"
            ],
            "metadata": {
                "azdata_cell_guid": "d3e6829e-7fae-47ff-bb13-4a0e5e5a2648",
                "language": "sql"
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "markdown",
            "source": [
                "pocet spojenyXnespojenych hovoru"
            ],
            "metadata": {
                "azdata_cell_guid": "67af2429-ecd2-4310-9294-5abbb14c0cf2"
            },
            "attachments": {}
        }
    ]
}