
--QUESTION 1
select count (u_id) from users;

--QUESTION 2
select count (*) from transfers where send_amount_currency = 'CFA';

--QUESTION 3
SELECT count (u_id) from transfers where send_amount_currency = 'CFA';

--QUESTION 4
SELECT COUNT (atx_id) FROM agent_transactions where extract (year from when_created) = 2018 
group by extract (month from when_created)

--QUESTION 5
WITH agentwithdrawers AS
(SELECT COUNT (agent_id) AS netwithdrawers from agent_transactions
HAVING count(amount) in (select count(amount) from agent_transactions where amount > -1 
AND amount !=0 having count(amount) >(SELECT COUNT (amount) from agent_transactions
where amount < 1 and amount !=0)))
select netwithdrawers from agentwithdrawers

--QUESTION 6
SELECT COUNT(atx.amount) as "atx volume city summary" ,ag.city
from agent_transactions AS atx LEFT OUTER JOIN agents as ag on atx.atx_id = ag.agent_id
where atx.when_created between now() :: date-extract(DOW FROM NOW())::INTEGER-7
AND NOW()::DATE-EXTRACT (DOW FROM NOW())::INTEGER GROUP BY ag.city

--QUESTION 7
SELECT COUNT(atx.amount) as "atx volume", count(ag.city) as "city", count(ag.country)
as "country" from agent_transactions as atx inner join agents AS ag ON
atx.atx_id =ag.agent_id group by ag.country

--QUESTION 8
select transfers.kind as kind, wallets.ledger_location as country,
sum (transfers.send_amount_scalar) AS volume from transfers INNER JOIN wallets
ON transfers.source_wallet_id = wallets.wallet_id where (transfers.when_created > (NOW() - INTERVAL '1 week'))
GROUP BY wallets.ledger_location, transfers.kind;

--QUESTION 9
SELECT COUNT(transfers.source_wallet_id) AS Unique_senders, count (transfer_id)
AS transactions_count, transfers.kind, wallets.ledger_location as country,
sum (transfers.send_amount_scalar) as volume from transfers inner join wallets 
on transfers.source_wallet_id = wallets.wallet_id where (transfers.when_created > (now() - interval '1 week'))
group by wallets.ledger_location, transfers.kind;

--QUESTION 10
select source_wallet_id, send_amount_scalar FROM transfers WHERE send_amount_currency = 'CFA' AND (send_amount_scalar>10000000) AND 
(transfers.when_created > (NOW() - INTERVAL '1 month'));
