/*
Cleaning Data in SQL Queries

*/

select *
from Data_Cleaning..NashvilleHousing


--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

select SaleDate, CONVERT(date, SaleDate) as [Date]
from Data_Cleaning..NashvilleHousing

/* Update Data_Cleaning..NashvilleHousing
SET SaleDate = CONVERT(date, SaleDate)

select SaleDate
from Data_Cleaning..NashvilleHousing

Somehow it is not working here. So, let us try using ALTER TABLE.
*/


-- If it doesn't Update properly

ALTER TABLE Data_Cleaning..NashvilleHousing
Add SaleDateConverted Date;

Update Data_Cleaning..NashvilleHousing
SET SaleDateConverted = CONVERT(date, SaleDate)

select SaleDateConverted
from Data_Cleaning..NashvilleHousing
 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from Data_Cleaning..NashvilleHousing a
JOIN Data_Cleaning..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is NULL


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from Data_Cleaning..NashvilleHousing a
JOIN Data_Cleaning..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is NULL
--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

/* select PropertyAddress
from Data_Cleaning..NashvilleHousing
*/
select 
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as StreetAddress
	,SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as StreetAddress
from Data_Cleaning..NashvilleHousing

ALTER TABLE Data_Cleaning..NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update Data_Cleaning..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE Data_Cleaning..NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update Data_Cleaning..NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))


select *
from Data_Cleaning..NashvilleHousing


--Now for owner address // Let us use PARSENAME function

select OwnerAddress
from Data_Cleaning..NashvilleHousing

select PARSENAME(REPLACE(OwnerAddress,',','.'),3) -- we are using REPLACE coz PASENAME only looks for periods (.)
, PARSENAME(REPLACE(OwnerAddress,',','.'),2)
, PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from Data_Cleaning..NashvilleHousing


ALTER TABLE Data_Cleaning..NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update Data_Cleaning..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE Data_Cleaning..NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update Data_Cleaning..NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE Data_Cleaning..NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update Data_Cleaning..NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

select *
from Data_Cleaning..NashvilleHousing




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field

select Distinct(SoldAsVacant), Count(SoldAsVacant)
from Data_Cleaning..NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END
from Data_Cleaning..NashvilleHousing

Update Data_Cleaning..NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END


-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates (doing just for practice purposes here, do not delete actual data in SQL)
-- We can use CTE 

WITH RowNumCTE AS(
select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
from Data_Cleaning..NashvilleHousing
--ORDER BY ParcelID
)
select *
from RowNumCTE
where row_num >1
order by PropertyAddress

-- to DELETE we just remove the select * as well as last ORDER BY from the above query

WITH RowNumCTE AS(
select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
from Data_Cleaning..NashvilleHousing
)
DELETE
from RowNumCTE
where row_num >1


---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns


select *
from Data_Cleaning..NashvilleHousing

ALTER TABLE Data_Cleaning..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE Data_Cleaning..NashvilleHousing
DROP COLUMN SaleDate

----THAT's IT!!!------THANK YOUUUU!!!