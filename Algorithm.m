%Pengambilan data
curah_hujan = cell2mat(readcell('data.xlsx','Range','B2:B36'))
kedalaman_air = cell2mat(readcell('data.xlsx','Range','C2:C36'))
keasaman_tanah = cell2mat(readcell('data.xlsx','Range','D2:D36'))
wilayah = readcell('data.xlsx','Range','A2:A36')

%Penentuan nilai maksimum/minimum
max_curah_hujan = max(curah_hujan)
max_kedalaman_air = max(kedalaman_air)
max_keasaman_tanah = max(keasaman_tanah)

%Penentuan BOBOT
bobot = [2 3 4]
bobot = bobot/sum(bobot)

%normalisasi
max_value = [max_curah_hujan,max_kedalaman_air,max_keasaman_tanah]
curah_hujan = curah_hujan/max_curah_hujan
kedalaman_air = kedalaman_air/max_kedalaman_air
keasaman_tanah = keasaman_tanah/max_keasaman_tanah
data_norm = [curah_hujan';kedalaman_air';keasaman_tanah']
data_norm = data_norm'

[m n] = size(data_norm)
result = []

for i=1:m
    result(i) = 0
    for j=1:n
        data_norm(i,j) = data_norm(i,j)*bobot(j)
        result(i) = result(i)+data_norm(i,j)
    end
end

%Pengurutan
j = result
result = result'
s_result = Quick_sort(result)
f_result = []
f_wilayah = wilayah

%Menentukan rangking tiap wilayah
for i=1:numel(result)
    for j=1:numel(result)
        if result(i) == s_result(j)
            f_result(j) = result(i)
            f_wilayah(j) = wilayah(i)
        end
    end
end


