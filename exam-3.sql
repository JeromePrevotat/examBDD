-- 1. Lister tous les plats avec un prix inférieur à 20 €.
SELECT * FROM dishes WHERE dishes.price < 20;

-- 2. Lister tous les plats des restaurants de cuisine Française et de cuisine Italienne en utilisant IN.
SELECT * FROM dishes
JOIN chefs
ON dishes.chef_id = chefs.id
JOIN restaurants
ON chefs.id = restaurants.id
WHERE cuisine_type IN ('Française', 'Italienne');

-- 3. Lister tous les ingrédients du Bœuf Bourguignon.


-- 4. Lister tous les chefs (leur nom uniquement) et leurs restaurants (leur nom uniquement).
-- 5. Lister les chefs et le nombre de plats qu'ils ont créés.
-- 6. Lister les chefs qui ont créé plus d'un plat.
-- 7. Calculez le nombre de chefs ayant créé un seul plat.
-- 8. Calculez le nombre de plats pour chaque type de cuisine.
-- 9. Calculez le prix moyen des plats par type de cuisine.
-- 10. Trouver le prix moyen des plats créés par chaque chef, en incluant seulement les chefs ayant créé plus de 2 plats