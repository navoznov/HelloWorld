FROM mcr.microsoft.com/dotnet/core/runtime:3.1 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["HelloWorld.csproj", "./"]
RUN dotnet restore "HelloWorld.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "HelloWorld.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HelloWorld.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
