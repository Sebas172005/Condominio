CREATE PROCEDURE sp_RegistrarReserva
    @id_area INT,
    @id_usuario INT,
    @fecha DATE,
    @hora_inicio TIME,
    @hora_fin TIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        BEGIN TRANSACTION;

        -- Validar si ya existe una reserva que choque en horario y área
        IF EXISTS (
            SELECT 1 
            FROM Reservas 
            WHERE id_area = @id_area 
              AND fecha = @fecha
              AND (
                   (@hora_inicio >= hora_inicio AND @hora_inicio < hora_fin) OR
                   (@hora_fin > hora_inicio AND @hora_fin <= hora_fin) OR
                   (@hora_inicio <= hora_inicio AND @hora_fin >= hora_fin)
                  )
        )
        BEGIN
            RAISERROR('Error: El horario seleccionado ya se encuentra reservado para esta área común.', 16, 1);
        END

        -- Insert seguro
        INSERT INTO Reservas (id_area, id_usuario, fecha, hora_inicio, hora_fin, estado)
        VALUES (@id_area, @id_usuario, @fecha, @hora_inicio, @hora_fin, 'Confirmada');

        COMMIT TRANSACTION;
        PRINT 'Reserva registrada con éxito.';
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
