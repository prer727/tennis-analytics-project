
SELECT c.competition_name, cat.category_name
FROM Competitions c JOIN Categories cat ON c.category_id = cat.category_id;

SELECT cat.category_name, COUNT(*) AS competition_count
FROM Competitions c JOIN Categories cat ON c.category_id = cat.category_id
GROUP BY cat.category_name ORDER BY competition_count DESC;

SELECT competition_name FROM Competitions WHERE type='doubles';

SELECT p.competition_name AS parent_competition, c.competition_name AS sub_competition
FROM Competitions c JOIN Competitions p ON c.parent_id = p.competition_id;

SELECT v.venue_name, c.complex_name
FROM Venues v JOIN Complexes c ON v.complex_id = c.complex_id;

SELECT country_name, COUNT(*) AS venue_count
FROM Venues GROUP BY country_name ORDER BY venue_count DESC;

SELECT c.name, r.rank, r.points
FROM Competitor_Rankings r JOIN Competitors c ON r.competitor_id = c.competitor_id
ORDER BY r.rank;

SELECT c.name, r.rank, r.movement
FROM Competitor_Rankings r JOIN Competitors c ON r.competitor_id = c.competitor_id
WHERE r.movement = 0;

SELECT c.country, SUM(r.points) AS total_points
FROM Competitor_Rankings r JOIN Competitors c ON r.competitor_id = c.competitor_id
WHERE c.country = 'Croatia'
GROUP BY c.country;
