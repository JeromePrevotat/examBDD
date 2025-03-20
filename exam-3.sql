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
SELECT * FROM ingredients
JOIN dishes
ON ingredients.dish_id = dishes.id
WHERE dishes.name = 'Bœuf Bourguignon';

-- 4. Lister tous les chefs (leur nom uniquement) et leurs restaurants (leur nom uniquement).
SELECT chefs.name, restaurants.name FROM chefs
JOIN restaurants
ON chefs.restaurant_id = restaurants.id
GROUP BY chefs.id;

-- 5. Lister les chefs et le nombre de plats qu'ils ont créés.
SELECT chefs.name, COUNT(dishes.chef_id) FROM chefs
JOIN dishes
ON chefs.id = dishes.chef_id
GROUP BY chef_id;

-- 6. Lister les chefs qui ont créé plus d'un plat.
SELECT chefs.name, COUNT(dishes.chef_id) FROM chefs
JOIN dishes
ON chefs.id = dishes.chef_id
GROUP BY dishes.chef_id
HAVING (COUNT(dishes.chef_id) >= 2);

-- 7. Calculez le nombre de chefs ayant créé un seul plat.
SELECT chefs.name, COUNT(dishes.chef_id) FROM chefs
JOIN dishes
ON chefs.id = dishes.chef_id
GROUP BY dishes.chef_id
HAVING (COUNT(dishes.chef_id) = 1);

-- 8. Calculez le nombre de plats pour chaque type de cuisine.
--SELECT COUNT()

-- 9. Calculez le prix moyen des plats par type de cuisine.
-- 10. Trouver le prix moyen des plats créés par chaque chef, en incluant seulement les chefs ayant créé plus de 2 plats