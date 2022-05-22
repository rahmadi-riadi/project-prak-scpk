function y = Quick_sort(x)

n = numel(x)

if n< 2
    y = x
    return;
end

n=length(x)

x_left=[]
x_right=[]

a_left = []
a_right = []

for i=1:(n-1)
    if x(i) > x(n)
        x_left = [x_left x(i)]
    else
        x_right = [x_right x(i)]
    end
end

y = [Quick_sort(x_left) x(n) Quick_sort(x_right)]

end