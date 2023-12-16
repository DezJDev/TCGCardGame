CREATE OR REPLACE FUNCTION P10_qteCardUser()
RETURNS TRIGGER AS $$
DECLARE
    nbCard INT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE P10_qteCardUser SET nbCards = nbCards + 1 WHERE userId = NEW.userId;

    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE P10_qteCardUser SET nbCards = nbCards + 1 WHERE userId = NEW.userId;
        UPDATE P10_qteCardUser SET nbCards = nbCards - 1 WHERE userId = OLD.userId;

    ELSIF TG_OP = 'DELETE' THEN
            UPDATE P10_qteCardUser SET nbCards = nbCards - 1 WHERE userId = OLD.userId;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--drop trigger if exists p10_update_card_count_trigger on p10_collection; -- pour les tests

CREATE TRIGGER P10_TrigqteCardUser
AFTER INSERT OR DELETE OR UPDATE ON P10_Collection
FOR EACH ROW
EXECUTE FUNCTION P10_qteCardUser();