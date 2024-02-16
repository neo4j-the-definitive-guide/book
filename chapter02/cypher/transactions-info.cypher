SHOW TRANSACTIONS YIELD *
RETURN transactionId, status, currentQueryId, currentQuery, 
resourceInformation.lockMode AS lockMode, 
resourceInformation.resourceType AS lockOnResource