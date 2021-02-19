


--excercise 1. which artists did not make any albums at all?
select *
from Artist
where ArtistId NOT IN (
	select ArtistId from Album
);


-- excercise 2. which artists did not record any tracks of the Latin genre?
select * from Artist
EXCEPT
select art.*
from Artist as art
	inner join Album as alb ON art.ArtistId = alb.AlbumId
	inner join Track as tra on alb.AlbumId = tra.AlbumId
	inner join Genre as gen on tra.GenreId = gen.GenreId
where gen.Name = 'Latin'


-- excercise 3. which video track has the longest length? (use media type table)
select Track.TrackId, Track.Name, Milliseconds
from Track where MediaTypeId IN (
	select MediaTypeId from MediaType where MediaType.Name = 'Protected MPEG-4 video file'
) AND Milliseconds in (
	select max(Milliseconds)
	from Track
);

select * from MediaType