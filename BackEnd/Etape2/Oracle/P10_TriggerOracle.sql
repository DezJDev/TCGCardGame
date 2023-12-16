CREATE OR REPLACE TRIGGER P10_TrigQteCardUser
    AFTER INSERT OR DELETE ON P10_Collection
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            UPDATE P10_qteCardUser SET nbCards=nbCards+1 WHERE userId = :NEW.userId;
        ELSE
            IF UPDATING THEN
                UPDATE P10_qteCardUser SET nbCards=nbCards+1 WHERE userId = :NEW.userId;
                UPDATE P10_qteCardUser SET nbCards=nbCards-1 WHERE userId = :OLD.userId;
            ELSE
                UPDATE P10_qteCardUser SET nbCards=nbCards-1 WHERE userId = :OLD.userId;
            END IF;
        END IF;
    END;

/*SELECT * FROM P10_qteCardUser;
INSERT INTO P10_Collection(cardId,userId) VALUES
((SELECT cardId FROM P10_Card WHERE cardImg = 'https://assets.tcgdex.net/en/bw/bw1/30/high.webp'), (SELECT userId FROM P10_User WHERE userName = 'ShadowRider'));
SELECT * FROM P10_qteCardUser;*/
