FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ADD . /nop
WORKDIR /nop/src/Presentation/Nop.Web
RUN mkdir published && \
    dotnet publish -c Release -o published/ Nop.Web.csproj && \
    mkdir ./published/bin  ./published/logs


FROM mcr.microsoft.com/dotnet/aspnet:8.0
COPY --from=build /nop/src/Presentation/Nop.Web/published /nop
WORKDIR /nop
EXPOSE 5000
CMD ["dotnet", "Nop.Web.dll", "--urls", "http://0.0.0.0:5000"]