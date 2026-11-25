FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ARG TARGETARCH
WORKDIR /src
COPY src/HelloApi/*.csproj src/HelloApi/
RUN dotnet restore src/HelloApi -a $TARGETARCH
COPY src/HelloApi src/HelloApi
RUN dotnet publish src/HelloApi -c Release -a $TARGETARCH --no-restore -o /out

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /out .
ENV ASPNETCORE_HTTP_PORTS=8080
EXPOSE 8080
USER $APP_UID
ENTRYPOINT ["dotnet", "HelloApi.dll"]