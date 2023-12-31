DROP VIEW P10_UserAndCards;
DROP VIEW P10_UserWithoutCard;
DROP VIEW P10_CardAndAttacks;

DROP TYPE P10_TableUserCard;
DROP TYPE P10_TABLEWeakness;
DROP TYPE P10_RECTableUserCard;
DROP TYPE P10_RECWeakness;

DROP PROCEDURE P10_ModifierUser;
DROP FUNCTION P10_RetournerAbilityEffet;
DROP FUNCTION P10_RetournerCartesUtilisateur;
DROP FUNCTION P10_RetournerFaiblesses;

DROP TRIGGER P10_TrigQteCardUser;

DROP SEQUENCE seq_ability;
DROP SEQUENCE seq_resistance;
DROP SEQUENCE seq_weakness;
DROP SEQUENCE seq_attack;
DROP SEQUENCE seq_card;
DROP SEQUENCE seq_user;

DROP TABLE P10_qteCardUser CASCADE CONSTRAINTS;
DROP TABLE P10_Collection CASCADE CONSTRAINTS;
DROP TABLE P10_Contient CASCADE CONSTRAINTS;
DROP TABLE P10_User CASCADE CONSTRAINTS;
DROP TABLE P10_Card CASCADE CONSTRAINTS;
DROP TABLE P10_Ability CASCADE CONSTRAINTS;
DROP TABLE P10_Attack CASCADE CONSTRAINTS;
DROP TABLE P10_Resistance CASCADE CONSTRAINTS;
DROP TABLE P10_Weakness CASCADE CONSTRAINTS;
