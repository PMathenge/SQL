+26771295344

--select COUNT(M.Agency) as Total, m.Agency FROM [SecretService].[dbo].[MainMaster] as M, [SecretService].[dbo].[AspNetUsers] as U where U.CohortId = M.id Group by M.Agency

/*select COUNT(G.CountyName) as Total, G.CountyName, M.Agency FROM [SecretService].[dbo].[MainMaster] as
M, [SecretService].[dbo].[AspNetUsers] as U, [SecretService].[dbo].[GeoMaster] as G   where U.CohortId = M.id  and M.subLocationCode = G.SubLocationId 
GROUP BY G.CountyName, M.Agency order by M.Agency*/

select COUNT(G.CountyName) as Total, G.CountyName, M.Agency, U.Sex FROM [SecretService].[dbo].[MainMaster] as
M, [SecretService].[dbo].[AspNetUsers] as U, [SecretService].[dbo].[GeoMaster] as G   where U.CohortId = M.id  and M.subLocationCode = G.SubLocationId 
GROUP BY G.CountyName, M.Agency, U.Sex order by M.Agency, U.Sex